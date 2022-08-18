module ResponseTemplate
    def self.template(message, content = {}, messages = [], code)
      response = { message: message, data: content, code: code }
      response[:messages] = messages if messages.present?
      Rails.logger.info Time.zone
      Rails.logger.info response
  
      response
    end
  
    def self.success(message, content = {}, code)
      template(message, content, code)
    end
  
    def self.error(message, content = {}, code)
      template(message, content, code)
    end
  
    def self.errors(messages, content = {}, code)
      template(messages.first, content, messages, code)
    end
  
    def self.unauthorized(message, content = {}, code)
      template(message, content, code)
    end
end
  