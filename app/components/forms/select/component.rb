class Forms::Select::Component < ApplicationComponent
  renders_one :field

  attr_accessor :object, :attribute

  def classes
    errors? ? ['forms-select--error'] : ['forms-select']
  end

  def errors?
    object&.errors&.key?(attribute)
  end

  def errors
    errors? ? object.errors.full_messages_for(attribute) : []
  end
end
