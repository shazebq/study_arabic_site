class UrlValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    unless value.blank?
      uri = URI.parse(value)
      unless uri.kind_of?(URI::HTTP)
        object.errors[attribute] << ("is not formatted properly") 
      end
    end
  rescue URI::InvalidURIError
    object.errors[attribute] << ("is not formatted properly")
  end
end

