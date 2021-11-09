class Forms::Label::Component < ApplicationComponent
  attr_accessor :object, :attribute

  def classes
    ['forms-label']
  end
end
