require 'rails_helper'

RSpec.describe Buyers::Steps::Component, type: :component do
  subject(:component) { described_class.new }

  before do
    render_inline(component) do |c|
      c.step(
        index: 1,
        current_index: 1,
        section: 'Stuff',
        path: '/',
        valid: true
      )
    end
  end

  it 'renders the step' do
    render_inline(component)
    expect(page).to have_link('Step 1').and have_link('Stuff')
  end
end
