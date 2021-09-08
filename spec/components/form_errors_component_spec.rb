require 'rails_helper'

RSpec.describe FormErrorsComponent, type: :component do
  let(:test_class) do
    stub_const('TestObject', Class.new do
      include ActiveModel::Validations
      extend ActiveModel::Naming
      attr_accessor :name, :city, :zip_code
    end)
  end

  let(:errors) { ActiveModel::Errors.new(test_class.new) }
  let(:component) { described_class.new(errors: errors) }

  context 'when there are no errors' do
    it 'is empty' do
      render_inline(component)
      expect(page.text).to be_blank
    end
  end

  context 'when there are errors' do
    before do
      errors.add(:name, :blank)
      errors.add(:city, :blank)
      errors.add(:zip_code, :blank)
    end

    it 'shows the error message' do
      render_inline(component)
      expect(page).to have_content(/Test object is missing: Name, City, Zip code/i)
    end

    it 'shows the error count' do
      render_inline(component)
      expect(page).to have_content(/There were 3 errors/i)
    end
  end
end
