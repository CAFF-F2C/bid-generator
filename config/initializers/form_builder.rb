require 'forms/form_builder'
Rails.application.config.to_prepare do
  ActionView::Base.default_form_builder = FormBuilder
end
