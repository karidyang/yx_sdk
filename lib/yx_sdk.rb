require "rest-client"
require "yx_sdk/version"
require "yx_sdk/handler/result_handler"
require "yx_sdk/api"
require "yx_sdk/client"


module YxSdk

  DEFAULT_CODE = 200

  class << self

    def http_post_without_token(url, post_body={}, url_params={}, header = {}, endpoint="plain")
      post_api_url = endpoint_url(endpoint, url)
      if endpoint == "plain" || endpoint == CUSTOM_ENDPOINT
        post_body = JSON.dump(post_body)
      end
      logger.info("request url is #{post_api_url}, header is #{header}")
      load_json(resource(post_api_url, header).post(post_body, params: url_params))
    end


    def resource(url, header)
      RestClient::Resource.new(url, header)
    end

    # return hash
    def load_json(string)
      result_hash = JSON.parse(string.force_encoding("UTF-8").gsub(/[\u0011-\u001F]/, ""))
      logger.info "response #{result_hash}"
      code   = result_hash.delete("code")
      info = result_hash.delete("info")
      ResultHandler.new(code, info)
    end

    def endpoint_url(endpoint, url)
      send("#{endpoint}_endpoint") + url
    end

    def plain_endpoint
      "#{api_endpoint}/nimserver"
    end

    def api_endpoint
      "https://api.netease.im"
    end


  end

end
