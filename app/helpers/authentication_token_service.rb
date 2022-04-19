# frozen_string_literal: true

class AuthenticationTokenService
  HMAC_SECRET = ENV['JWT_SECRET']
  # ALGORITHM_TYPE = 'RS512'
  ALGORITHM_TYPE = 'HS256'
  EXP = Time.now.to_i + (1 * 3600) # 4 hours
  AUD = ['!@(&#(Cc898)S(*D&', '(S&*90caLSCM<lasc;l )', '90890a8s90(*#(@c.~cd;d.;'].freeze
  IAT = Time.now.to_i
  JTI_RAW = [HMAC_SECRET, IAT].join(':').to_s
  JTI = Digest::MD5.hexdigest(JTI_RAW)
  JWK = JWT::JWK.new(OpenSSL::PKey::RSA.new(2048), 'optional-kid')
  ISS = %w[hatienloi 261299].freeze

  JWK_LOADER = lambda do |options|
    @cached_keys = nil if options[:invalidate] # need to reload the keys
    @cached_keys ||= { keys: [JWK.export] }
  end

  def self.encode(user_id)
    payload = { user_id: user_id, exp: EXP, aud: AUD, iat: IAT, iss: ISS, jti: JTI, type: TOKEN, timestamp: Time.current }
    # headers = { kid: JWK.kid }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
    # JWT.encode payload, JWK.keypair, ALGORITHM_TYPE, headers
  end

  def self.decode(token)
    info = JWT.decode(token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE })[0]
    return nil if info['type'] != TOKEN

    info
    # JWT.decode(token, nil, true, { algorithm: [ALGORITHM_TYPE], jwks: JWK_LOADER })[0]
  rescue StandardError
    nil
  end

  def self.encode_renew_token(user_id)
    payload = { user_id: user_id, type: RENEW, timestamp: Time.current }
    JWT.encode payload, HMAC_SECRET, ALGORITHM_TYPE
  end

  def self.decode_renew_token(renew_token)
    info = JWT.decode(renew_token, HMAC_SECRET, true, { algorithm: ALGORITHM_TYPE })[0]
    return nil if info['type'] != RENEW

    info
  rescue StandardError
    nil
  end
end
