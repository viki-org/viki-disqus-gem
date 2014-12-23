require 'base64'
require 'openssl'

module VikiDisqus
  # Disqus SSO Doc: http://help.disqus.com/customer/portal/articles/236206-integrating-single-sign-on
  class SSO
    DISQUS_SECRET_KEY = ENV["DISQUS_SECRET_KEY"]
    DISQUS_PUBLIC_KEY = ENV["DISQUS_PUBLIC_KEY"]

    def self.remote_auth_s3(opts, timestamp)
      "#{message(opts)} #{signature(opts, timestamp)} #{timestamp}"
    end

    def self.signature(opts, timestamp)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                              DISQUS_SECRET_KEY,
                              "#{message(opts)} #{timestamp}")
    end

    # Validate message: http://disqus.com/api/sso/
    def self.message(opts)
      message = {'id' => opts['id'], 'username' => opts['username'], 'email' => opts['email']}
      message.merge!({'url' => opts['url']}) if opts.has_key?('url')
      message.merge!({'avatar'=> opts['avatar']}) if opts.has_key?('avatar')

      Base64.strict_encode64(message.to_json).gsub("\n", "")
    end
  end
end
