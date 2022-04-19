# frozen_string_literal: true

class AuthenticatorGoogleAuth2
  def fetch_google_user_info(access_token)
    conn = Faraday.new(
      headers: { 'authorization' => "Bearer #{access_token}" }
    )
    resp = conn.get ENV['GOOGLE_AUTH2_USER_INFO']
    return nil unless resp.success?

    JSON.parse(resp.body)
  end
end
