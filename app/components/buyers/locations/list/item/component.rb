class Buyers::Locations::List::Item::Component < ApplicationComponent
  with_collection_parameter :item
  attr_accessor :item

  def self.initialize_parameter_names
    [:item]
  end
end
