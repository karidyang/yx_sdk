require "rest-client"
require "yx_sdk/version"
require "yx_sdk/handler/result_handler"
require "yx_sdk/api"
require "yx_sdk/client"
if defined? Yajl
  require 'yajl/json_gem'
else
  require "json"
end

module YxSdk

  DEFAULT_CODE = 200

  class << self

    def http_post_without_token(url, url_params={}, header = {}, endpoint="plain")
      post_api_url = endpoint_url(endpoint, url)
      post_body = ''
      if endpoint == "plain" || endpoint == CUSTOM_ENDPOINT
        url_params.each {|k,v| post_body = post_body + "#{k}=#{v}&"}
      end
      puts "request url is #{post_api_url}, header is #{header}, post_body is #{post_body[0..-1]}"
      load_json(resource(post_api_url, header).post(post_body[0..-1]))
    end


    def resource(url, header)
      RestClient::Resource.new(url, :headers => header)
    end

    # return hash
    def load_json(string)
      result_hash = JSON.parse(string.force_encoding("UTF-8").gsub(/[\u0011-\u001F]/, ""))
      puts "response #{result_hash}"
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
