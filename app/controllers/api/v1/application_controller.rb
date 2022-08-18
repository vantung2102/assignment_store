class Api::V1::ApplicationController < ApplicationController

    protected

    def success_message(message, content = {}, code = 200)
      ResponseTemplate.success(message, content, code)
    end
  
    def error_message(message, content = {}, code = 500)
      ResponseTemplate.error(message, content, code)
    end
  
    def unauthorized_message(message, content = {}, code = 401)
      ResponseTemplate.unauthorized(message, content, code)
    end
  
    # def gravatar_for_user(user, size = 40)
    #   gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    #   "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    # end
  
    def serializers(data, serializer, scope: nil)
      ActiveModelSerializers::SerializableResource.new(data,
                                                       each_serializer: serializer, scope: scope)
    end
end
  