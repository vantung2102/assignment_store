class PhoneNumberValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /^[0-9]{10,10}*$/
        record.errors[attribute] << (options[:message] || "is invalid")
      end
    end
end