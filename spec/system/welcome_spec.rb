require 'rails_helper'

RSpec.describe 'Welcome Page', type: :system do
  it 'shows the welcome page', :js do
    visit ''
    expect(page).to have_content(/bid generator/i)
    expect(page).to be_axe_clean
  end
end
