# frozen_string_literal: true

require_relative '../../../../common/helper'

module Api
  module V1
    class UsersController < ApplicationController
      def index
        return forbidden unless permission?('admin', 'read')

        active = if params[:active]
                   JSON.parse params[:active]
                 else
                   [true, false]
                 end
        user = User
               .get_info_user
               .where(statuses: { active: active })
               .where("email ILIKE '%#{params[:email]}%'")
               .paging(params[:page], params[:per_page]).order(updated_at: :desc)
        render json: {
          **pagination(user),
          data: user.map { |tmp| UserSerializer.new(tmp).serializable_hash }
        }, adapter: nil, status: :ok
      end

      def show
        render json: User.find(params[:id]), status: :ok
      end

      def destroy
        return forbidden unless permission?('viewer', 'read')

        user = User.find(params[:id])
        user.destroy!
        head :no_content
      end

      def me
        render json: @current_user, status: :ok
      end

      def search_by_email
        email = params[:email]
        username = params[:username]

        # user = User.where(email: email)
        #
        # puts user.analyze

        user = User.username_similar(username)

        puts user.analyze

        render json: user, adapter: nil, status: :ok
      end

      def similarity(word1, word2)
        tri1 = trigram(word1)
        tri2 = trigram(word2)

        return 0.0 if [tri1, tri2].any? { |arr| arr.size.zero? }

        # Find number of trigrams shared between them
        same_size = (tri1 & tri2).size
        # Find unique total trigrams in both arrays
        all_size = (tri1 | tri2).size

        same_size.to_f / all_size
      end

      def trigram(word)
        return [] if word.strip == ''

        parts = []
        padded = "  #{word} ".downcase
        padded.chars.each_cons(3) { |w| parts << w.join }
        parts
      end

      private

      def user_params
        params.require(:user).permit(:active, :email)
      end
    end
  end
end
