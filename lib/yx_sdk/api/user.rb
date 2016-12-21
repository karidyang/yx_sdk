module YxSdk

  module Api
    module User
      #同步创建
      def create(id, name, icon, token)
        user_info_url = "#{user_base_url}/create.action"
        http_post(user_info_url, {accid: id, name: name, icon: icon, token: token})
      end

      private

      def user_base_url
        "/user"
      end

    end
  end
end