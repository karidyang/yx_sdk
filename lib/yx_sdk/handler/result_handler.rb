module YxSdk
  class ResultHandler
    attr_accessor :code, :result

    def initialize(code, result = {})
      @code = code || DEFAULT_CODE
      @result = package_result(result)
    end

    private

    # if define Rails constant
    # result = WeixinAuthorize::ResultHandler.new("0", "success", {:ok => "true"})
    # result.result["ok"] #=> true
    # result.result[:ok] #=> true
    # result.result['ok'] #=> true
    def package_result(result)
      return result unless result.is_a?(Hash)
      if defined?(Rails)
        ActiveSupport::HashWithIndifferentAccess.new(result)
      else
        result
      end
    end

  end
end