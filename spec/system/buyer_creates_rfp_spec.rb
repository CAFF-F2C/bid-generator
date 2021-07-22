require 'rails_helper'

RSpec.describe 'Creates an RFP', type: :system do
  let!(:buyer) { create(:buyer) }

  it 'allows the buyer to create their district profile', :js do
    login_as(buyer, scope: :buyer)

    visit(buyers_root_path)

    click_on('District Profile')
    expect(page).to have_content('District Profile')

    # fill_in('School District Name').with 'The District'
  end
end
