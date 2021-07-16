require 'rails_helper'

RSpec.describe 'smoke test', type: :system do
  it 'works' do
    visit ''
    expect(page).to be_axe_clean
    expect(page).to have_content(/bid generator/i)
  end
end
