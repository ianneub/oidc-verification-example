require 'jwt'
require 'httparty'

token = ARGV[0]

def keys
  res = HTTParty.get('https://token.actions.githubusercontent.com/.well-known/jwks')
  res.parsed_response['keys']
end

def raw_key_by_kid(kid)
  keys.find{|key| key['kid'] == kid}['x5c'].first
end

_, header = JWT.decode(token, nil, false)
raw_key = raw_key_by_kid(header['kid'])
key = OpenSSL::X509::Certificate.new(Base64.decode64(raw_key))

payload, headers = JWT.decode(token, key.public_key, true,
  algorithm: 'RS256',

  iss: 'https://token.actions.githubusercontent.com',
  verify_iss: true,

  aud: 'https://github.com/ianneub',
  verify_aud: true,

  sub: 'repo:ianneub/oidc-verification-example:ref:refs/heads/main',
  verify_sub: true,
)

puts 'Headers:'
puts JSON.pretty_generate(headers)

puts 'Payload:'
puts JSON.pretty_generate(payload)
