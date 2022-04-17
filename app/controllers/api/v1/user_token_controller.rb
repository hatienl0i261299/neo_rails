# frozen_string_literal: true

module Api
  module V1
    class UserTokenController < ApplicationController
      class AuthenticationError < StandardError; end

      rescue_from AuthenticationError, with: :handle_error

      skip_before_action :authenticate_user, only: %i[create_user_token github]

      def create_user_token
        raise AuthenticationError unless user.authenticate(params.require(:password))

        token = AuthenticationTokenService.encode(user.id)

        render json: { token: token }, adapter: nil, status: :created
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

        user = User.find_by_email user_github_info['email']
        unless user.present?
          user = User.create! first_name: user_github_info['name'],
                              email: user_github_info['email'],
                              status_id: 1,
                              group_id: 1,
                              password: 'root'
        end
        access_token = AuthenticationTokenService.encode(user.id)
        render json: {
          **access_token_github,
          access_token: access_token
        }, status: :ok
      end

      private

      def user
        @user ||= User.find_by(username: params.require(:username))
        @user || (raise AuthenticationError)
      end

      def handle_error
        head :unauthorized
      end
    end
  end
end
