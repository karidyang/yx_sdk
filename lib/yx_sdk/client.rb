require 'digest/md5'
module YxSdk
  
  class Client

    include Api::User

    attr_accessor :app_key, :app_secret

    def initialize(app_key, app_secret)
      @app_key = app_key
      @app_secret = app_secret
    end

    # 暴露出：http_get,http_post两个方法，方便第三方开发者扩展未开发的微信API。
    def http_post(url, url_params={}, endpoint="plain")
      # url_params = url_params.merge(access_token_param)
      YxSdk.http_post_without_token(url, url_params, get_header, endpoint)
    end

    def get_header
      timestamp = Time.now.to_i
      noncestr = SecureRandom.hex(16)
      str = "#{app_secret}#{noncestr}#{timestamp}"
      signature = Digest::SHA1.hexdigest(str)
      {
          "AppKey" => @app_key,
          "Nonce" => noncestr,
          "CurTime" => timestamp,
          "CheckSum" => signature,
          "Content-Type" => "application/x-www-form-urlencoded;charset=utf-8"
      }
    end
  end
end