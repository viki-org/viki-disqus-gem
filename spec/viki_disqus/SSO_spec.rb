require_relative "../spec_helper"
require "json"

describe VikiDisqus::SSO do
  let(:user_hash) { {'id' => 1, "username" => "admin", "email" => "admin@viki.com"} }
  let(:timestamp) { 1360142584 }

  describe "#signature" do
    it "generate the signature of a given user" do
      described_class.signature(user_hash, timestamp).should ==
          OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                  VikiDisqus::SSO::DISQUS_SECRET_KEY,
                                  "#{Base64.strict_encode64(user_hash.to_json).gsub("\n", "")} #{timestamp}")
    end
  end

  describe "#message" do
    it "return the base64 message" do
      described_class.message(user_hash).should ==
          Base64.encode64(user_hash.to_json).gsub("\n", "")
    end

    it "handles optional acceptable hash" do
      user_hash.merge!({'url'=>"some_url", 'avatar'=>"some_avatar"})
      described_class.message(user_hash).should ==
          Base64.encode64(user_hash.to_json).gsub("\n", "")
    end

    it "does not handle unacceptable hash" do
      extra_user_hash = user_hash.merge({'some_extra'=>'hash_not_needed_by_disqus'})
      described_class.message(extra_user_hash).should ==
          Base64.encode64(user_hash.to_json).gsub("\n", "")
    end
  end

  describe "#remote_auth_s3" do
    it "returns the signed message" do
      described_class.remote_auth_s3(user_hash, timestamp).should ==
          "#{described_class.message(user_hash)} #{described_class.signature(user_hash, timestamp)} #{timestamp}"
    end
  end
end
