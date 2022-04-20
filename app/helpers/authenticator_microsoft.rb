# frozen_string_literal: true

class AuthenticatorMicrosoft
  def fetch_microsoft_user_info(access_token)
    conn = Faraday.new(
      headers: { 'authorization' => "Bearer #{access_token}" }
    )
    resp = conn.get ENV['MICROSOFT_AUTH2_USER_INFO']
    return nil unless resp.success?

    JSON.parse(resp.body)
  end
end
