class AuthenticatorFacebookAuth2
  def initialize(connection = Faraday.new)
    @connection = connection
  end

  def fetch_facebook_user_info(access_token)
    puts ENV['FACEBOOK_AUTH2_USER_INFO']
    resp = @connection.get ENV['FACEBOOK_AUTH2_USER_INFO'], {
      access_token: access_token,
      fields: FIELDS_FACEBOOK_API_USER_INFO
    }
    return nil unless resp.success?

    JSON.parse(resp.body)
  end
end