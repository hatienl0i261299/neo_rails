# frozen_string_literal: true

class AuthenticatorGithub
  def initialize(connection = Faraday.new)
    @connection = connection
  end

  def github(code)
    access_token_resp = fetch_github_access_token(code)
    access_token = access_token_resp['access_token']
    user_info_resp = fetch_github_user_info(access_token)

    {
      issuer: ENV['FLASHCARDS_CLIENT_URL'],
      login: user_info_resp['login'],
      name: user_info_resp['name'],
      avatar_url: user_info_resp['avatar_url']
    }
  end

  def fetch_github_access_token(code)
    resp = @connection.post ENV['GITHUB_ACCESS_TOKEN_URL'], {
      code: code,
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET']
    }
    raise IOError, 'FETCH_ACCESS_TOKEN' unless resp.success?

    URI.decode_www_form(resp.body).to_h
  end

  def fetch_github_user_info(access_token)
    conn = Faraday.new(
      headers: { 'authorization' => "Bearer #{access_token}" }
    )
    resp = conn.get ENV['GITHUB_USER_INFO_URL']
    return nil unless resp.success?

    JSON.parse(resp.body)
  end
end
