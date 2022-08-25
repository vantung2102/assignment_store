class PasswordValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x
        record.errors[attribute] << (options[:message] || "is invalid")
      end
    end
end