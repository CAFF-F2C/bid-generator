require 'rails_helper'

RSpec.describe 'Creates an RFP', type: :system do
  let!(:buyer) { create(:buyer, :confirmed) }
  let(:current_year) { 1.hour.from_now.year }

  let(:procurement_type) { create(:procurement_type, name: 'Test Type', published: true) }
  let(:preset) { create(:score_preset, name: 'ScorePreset', procurement_type: procurement_type) }

  let(:price) { create(:score_category, name: 'Item Prices') }
  let(:cat4) { create(:score_category, name: 'Cat 4') }
  let(:cat3) { create(:score_category, name: 'Cat 3') }
  let(:cat2) { create(:score_category, name: 'Cat 2') }

  before do
    procurement_type.template.attach(io: File.open('spec/fixtures/files/RFP_Template.docx'), filename: 'RFP_Template.docx')
    procurement_type.procurement_type_score_categories.create(score_category: price, position: 1)
    procurement_type.procurement_type_score_categories.create(score_category: cat2, position: 2)
    procurement_type.procurement_type_score_categories.create(score_category: cat3, position: 3)
    procurement_type.procurement_type_score_categories.create(score_category: cat4, position: 4)

    create(:score_preset_value, score_preset: preset, score_category: price, value: 55)
    create(:score_preset_value, score_preset: preset, score_category: cat3, value: 25)
    create(:score_preset_value, score_preset: preset, score_category: cat4, value: 1)
  end

  it 'allows the buyer to create their district profile', :js do
    login_as buyer, scope: :buyer

    visit buyers_root_path
    expect(page).to have_content('must complete your District Profile')

    click_on 'District Profile'
    expect(page).to have_content('District Profile')

    fill_in 'District name', with: 'The District'
    fill_in 'City', with: 'The City'
    fill_in 'County', with: 'The County'

    click_on 'Save draft'
    expect(page).to have_selector('.forms-errors')

    click_on 'RFP Contact'

    fill_in 'Full name', with: 'FS Director'
    fill_in 'Department name', with: 'School Meals R Us'
    fill_in 'Title', with: 'FS Director'
    fill_in 'Phone number', with: '5551234567'
    fill_in 'Mailing address', with: '123 Edu Lane'
    fill_in 'City', with: 'Cityname'
    fill_in 'State', with: 'California'
    fill_in 'ZIP code', with: '123456'

    click_on 'Next'

    select '35%', from: 'Local percentage'
    choose 'Do not verify pricing'
    choose 'Do not add a piggyback clause'
    fill_in 'Per-incident liability limit', with: '1_000_000'
    fill_in 'Aggregate liability limit', with: '2_000_000'
    fill_in 'Automobile liability limit', with: '500_000'

    click_on 'Next'

    click_on 'New delivery site'

    fill_in 'Name', with: 'Deliver here'
    fill_in 'Street address', with: '123 Main Way'
    fill_in 'City', with: 'The City'
    fill_in 'State', with: 'CA'
    fill_in 'ZIP code', with: '12345'

    click_on 'Save'
    expect(page).to have_content(/Deliver here/i)
    expect(page).to have_content('123 Main Way').and have_content('The City').and have_content('CA').and have_content('12345')

    click_on 'New delivery site'

    fill_in 'Name', with: 'Deliver now'

    click_on 'Cancel'
    expect(page).to have_content(/Deliver here/i)

    click_on 'Review profile'

    expect(page).to have_content('Incomplete')

    click_on 'Update', match: :first

    fill_in 'Number of enrolled students', with: '1000'

    click_on 'Save draft'

    click_on 'District Profile'

    expect(page).to have_content(/the district/i)
    expect(page).to have_content(/fs director/i)
    expect(page).to have_content(/school meals r us/i)
    expect(page).to have_content(/fs director/i)
    expect(page).to have_content(/5551234567/i)
    expect(page).to have_content(/123 edu lane/i)
    expect(page).to have_content(/cityname/i)
    expect(page).to have_content(/ca/i)
    expect(page).to have_content(/123456/i)

    expect(page).to have_content(/35%/i)
    expect(page).to have_content('$1,000,000')
    expect(page).to have_content('$2,000,000')
    expect(page).to have_content('$500,000')

    click_on 'Requests for Proposals'

    click_on 'New proposal'
    select "#{current_year} - #{current_year + 1}", from: 'School year'
    select 'Test Type', from: 'Procurement type'

    click_on 'Next'

    click_on 'ScorePreset'
    expect(page).to have_content('Previewing the ScorePreset preset')
    click_on 'Apply'

    expect(page).to have_content('Price')
    expect(page.find('#rfp_total_score')).to have_content('81')

    fill_in 'Cat 2', with: '22'
    expect(page.find('#rfp_total_score')).to have_content('103')

    expect(page.find('.form-errors__error')).to have_content('Total must equal 100')

    fill_in 'Cat 2', with: '19'
    expect(page).not_to have_selector('.form-errors__error')
    expect(page.find('#rfp_total_score')).to have_content('100')

    click_on 'Next'

    click_on 'New delivery time'

    select 'Deliver here', from: 'Delivery site'
    check 'Monday'
    check 'Wednesday'
    select '2', from: 'Deliveries per week'
    select '6:00 am', from: 'Start time'
    select '8:00 am', from: 'End time'

    click_on 'Save delivery schedule'

    expect(page).to have_content('Deliver here')
    expect(page).to have_content('2x per week')
    expect(page).to have_content('Mon').and have_content('Wed')
    expect(page).to have_content('6:00 am').and have_content('8:00 am')

    click_on 'Deliver here'

    select '12:00 pm', from: 'Start time'
    select '2:00 pm', from: 'End time'

    click_on 'Cancel'

    expect(page).to have_content('6:00 am').and have_content('8:00 am')

    click_on 'Next'

    page.attach_file('Upload an item list', 'spec/fixtures/files/item_list.txt')
    expect(page).to have_content('item_list.txt')

    click_on 'Requests for Proposals'

    expect(page).to have_content('Complete').and have_content('Test Type').and have_content(current_year).and have_content(current_year + 1)

    click_on 'Test Type'
    click_on 'Update', match: :first

    select "#{current_year} - #{current_year + 1}", from: 'School year'

    click_on 'Save draft'

    click_on 'Requests for Proposals'

    expect(page).to have_content('Complete').and have_content('Test Type').and have_content(current_year).and have_content(current_year + 1)

    click_on 'Test Type'

    expect(page).to have_link('Download')
  end
end
