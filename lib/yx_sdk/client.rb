module YxSdk
  class Client
    attr_accessor app_key, app_secret

    def initialize(app_key, app_secret, options={})
      @app_key = app_key
      @app_secret = app_secret
      super()
    end

    # 暴露出：http_get,http_post两个方法，方便第三方开发者扩展未开发的微信API。
    def http_post(url, post_body={}, url_params={}, endpoint="plain")
      # url_params = url_params.merge(access_token_param)
      YxSdk.http_post_without_token(url, post_body, url_params, get_header, endpoint)
    end

    def get_header
      timestamp = Time.now.to_i
      noncestr = SecureRandom.hex(16)
      str = "#{AppSecret}#{noncestr}#{timestamp}"
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