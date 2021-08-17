require 'rails_helper'

RSpec.describe 'Creates an RFP', type: :system do
  let!(:buyer) { create(:buyer, :confirmed) }

  it 'allows the buyer to create their district profile', :js do
    login_as buyer, scope: :buyer

    visit buyers_root_path

    click_on 'District Profile'
    expect(page).to have_content('District Profile')

    fill_in 'District Name', with: 'The District'
    click_on 'Next'

    expect(page).to have_content('Contact Information')
    fill_in 'Full name', with: 'FS Director'
    fill_in 'Department name', with: 'School Meals R Us'
    fill_in 'Title', with: 'FS Director'
    fill_in 'Phone number', with: '5551234567'
    fill_in 'Mailing address', with: '123 Edu Lane'
    fill_in 'City', with: 'Cityname'
    fill_in 'State', with: 'Thestate'
    fill_in 'ZIP code', with: '123456'
    click_on 'Save and exit'

    expect(page.find('main')).to have_content(/success/i)

    expect(page).to have_content(/the district/i)
    expect(page).to have_content(/fs director/i)
    expect(page).to have_content(/school meals r us/i)
    expect(page).to have_content(/fs director/i)
    expect(page).to have_content(/5551234567/i)
    expect(page).to have_content(/123 edu lane/i)
    expect(page).to have_content(/cityname/i)
    expect(page).to have_content(/thestate/i)
    expect(page).to have_content(/123456/i)

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
