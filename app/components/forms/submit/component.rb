class Forms::Submit::Component < ApplicationComponent
  attr_accessor :object
  attr_writer :classes

  def classes
    ['forms-submit'].concat(Array(@classes))
  end
end
