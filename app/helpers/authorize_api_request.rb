# frozen_string_literal: true

# Authorize API Request
class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token['user_id']) if decoded_auth_token
  end

  def decoded_auth_token
    @decoded_auth_token ||= AuthenticationTokenService.decode(http_auth_header) if http_auth_header
  end

  def http_auth_header
    return headers['Authorization'].split.last if headers['Authorization'].present?

    nil
  end
end
