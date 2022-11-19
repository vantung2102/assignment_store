class PasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value =~ /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x || value.blank?

    record.errors[attribute] << (options[:message] || 'is invalid')
  end
end
