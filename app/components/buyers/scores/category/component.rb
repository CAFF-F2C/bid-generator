class Buyers::Scores::Category::Component < ApplicationComponent
  attr_accessor :name, :value

  def render?
    Integer(value).positive?
  end
end
