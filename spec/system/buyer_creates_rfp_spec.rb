require 'rails_helper'

RSpec.describe 'Creates an RFP', type: :system do
  let!(:buyer) { create(:buyer, :confirmed) }

  it 'allows the buyer to create their district profile', :js do
    login_as buyer, scope: :buyer

    visit buyers_root_path

    click_on 'District Profile'
    expect(page).to have_content('District Profile')

    fill_in 'District Name', with: 'The District'
    click_on 'Save and exit'

    expect(page.find('main')).to have_content(/success/i)

    click_on('Documents')

    click_on('New RFP')

    select '2021 - 2022', from: 'rfp_start_year'
    select 'Produce', from: 'rfp_bid_type'

    click_on 'Save and exit'
    expect(page.find('main')).to have_content('Produce (2021 - 2022)')
    click_on 'edit'
    select '2022 - 2023', from: 'rfp_start_year'
    click_on 'Save and exit'
    expect(page.find('main')).to have_content('Produce (2022 - 2023)')
  end
end
