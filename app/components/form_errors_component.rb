class FormErrorsComponent < ViewComponent::Base
  def initialize(errors:, scope: nil)
    @errors = errors
    @scope = scope
  end

  def render?
    @errors.present?
  end

  def errors_display
    return @errors.full_messages unless @scope

    errors_by_type.map do |type, group|
      t(type, model: model_name, attributes: group.collect { |e| attribute_name(e.attribute) }.join(', '), scope: [:activemodel, :errors, @scope, :messages])
    end
  end

  def errors_by_type
    @errors.group_by(&:type)
  end

  def model_name
    base.model_name.human
  end

  def attribute_name(attribute)
    base.class.human_attribute_name(attribute, {base: base})
  end

  def base
    @errors.first.base
  end
end
