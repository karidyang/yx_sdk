module YxSdk

  module Api
    module User
      #同步创建
      def create(params={})
        user_info_url = "#{user_base_url}/create.action"
        http_post(user_info_url, params)
      end

      def update(params={})
        user_info_url = "#{user_base_url}/update.action"
        http_post(user_info_url, params)
      end

      def refreshToken(accid)
        user_info_url = "#{user_base_url}/refreshToken.action"
        http_post(user_info_url, {accid: accid})
      end

      private

      def user_base_url
        "/user"
      end

    end
  end
end