class Forms::TextField::Component < ApplicationComponent
  renders_one :field

  attr_accessor :object, :attribute

  def classes
    result = ['forms-text-field__input']
    result << 'forms-text-field__input--error' if errors?
    result
  end

  def errors?
    object&.errors&.key?(attribute)
  end

  def errors
    errors? ? object.errors.full_messages_for(attribute) : []
  end
end
