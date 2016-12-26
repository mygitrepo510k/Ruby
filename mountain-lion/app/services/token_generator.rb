require 'securerandom'
module TokenGenerator
  def self.generate_random_token
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end
end
