class ComponentFormBuilder < ActionView::Helpers::FormBuilder
  def text_field(attribute, options = {})
    @template.render Forms::TextField::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def email_field(attribute, options = {})
    @template.render Forms::TextField::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def password_field(attribute, options = {})
    @template.render Forms::TextField::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def number_field(attribute, options = {})
    @template.render Forms::TextField::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def telephone_field(attribute, options = {})
    @template.render Forms::TextField::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def label(attribute, text = nil, options = {})
    @template.render Forms::Label::Component.new(object: @object, attribute: attribute) do |component|
      super(attribute, text, options.compact.reverse_merge(class: component.classes)) + (yield(component) if block_given?)
    end
  end

  def radio_button(attribute, value, options = {})
    @template.render Forms::RadioButton::Component.new(object: @object) do |component|
      super(attribute, value, options.merge(class: component.classes)) + (yield(component) if block_given?)
    end
  end

  def check_box(attribute, options = {}, checked_value = '1', unchecked_value = '0')
    @template.render Forms::CheckBox::Component.new(object: @object) do |component|
      super(attribute, options.merge(class: component.classes), checked_value, unchecked_value) + (yield(component) if block_given?)
    end
  end

  def select(attribute, choices = nil, options = {}, html_options = {})
    @template.render Forms::Select::Component.new(object: @object, attribute: attribute) do |component|
      component.field { super(attribute, choices, options, html_options.merge(class: component.classes)) }
      yield(component) if block_given?
    end
  end

  def submit(text = nil, options = {})
    @template.render Forms::Submit::Component.new(object: @object) do |component|
      super(text, options.merge(class: component.classes)) + (yield(component) if block_given?)
    end
  end
end
