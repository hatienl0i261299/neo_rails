# frozen_string_literal: true

module Api
  module V1
    class UserTokenController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from AuthenticationError, with: :handle_error

      skip_before_action :authenticate_user, only: %i[create_user_token github renew_access_token google_auth2 facebook_auth2]

      def create_user_token
        raise AuthenticationError unless user.authenticate(params.require(:password))

        render json: get_new_access_token(user.id), adapter: nil, status: :created
      end

      def renew_access_token
        renew_token = params[:renew_token]
        return bad_request 'Renew token is required' unless renew_token

        info_token = AuthenticationTokenService.decode_renew_token(renew_token)
        user_id = info_token.try(:[], 'user_id')
        puts user_id
        return bad_request 'Error renew_token' unless user_id

        render json: get_new_access_token(user_id), status: :ok
      end

      def google_auth2
        authenticator = AuthenticatorGoogleAuth2.new
        user_google_info = authenticator.fetch_google_user_info(params[:code])

        return head :unauthorized unless user_google_info['email']

        user = create_user_from_social(user_google_info['name'], user_google_info['email'])

        render json: {
          **get_new_access_token(user.id)
        }, status: :ok
      end

      def facebook_auth2
        authenticator = AuthenticatorFacebookAuth2.new
        user_facebook_info = authenticator.fetch_facebook_user_info(params[:code])

        return head :unauthorized unless user_facebook_info['email']

        user = create_user_from_social("#{user_facebook_info['first_name']} #{user_facebook_info['last_name']}".strip, user_facebook_info['email'])

        render json: {
          **get_new_access_token(user.id)
        }, status: :ok
      end

      def github
        authenticator = AuthenticatorGithub.new
        access_token_github = authenticator.fetch_github_access_token params[:code]
        puts access_token_github.as_json
        access_token = access_token_github['access_token']

        return head :unauthorized unless access_token

        user_github_info = authenticator.fetch_github_user_info(access_token)
        puts user_github_info.as_json

        return head :unauthorized unless user_github_info['email']

        user = create_user_from_social(user_github_info['name'], user_github_info['email'])
        render json: {
          **access_token_github,
          **get_new_access_token(user.id)
        }, status: :ok
      end

      private

      def create_user_from_social(name, email)
        user = User.find_by_email email
        unless user.present?
          user = User.create! first_name: name,
                              email: email,
                              status_id: 1,
                              group_id: 1,
                              password: 'root'
        end
        user
      end

      def user
        @user ||= User.find_by(username: params.require(:username))
        @user || (raise AuthenticationError)
      end

      def get_new_access_token(user_id)
        {
          access_token: AuthenticationTokenService.encode(user_id),
          renew_token: AuthenticationTokenService.encode_renew_token(user_id)
        }
      end

      def handle_error
        head :unauthorized
      end
    end
  end
end
