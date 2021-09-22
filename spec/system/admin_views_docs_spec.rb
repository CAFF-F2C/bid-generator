require 'rails_helper'

RSpec.describe 'Log in', type: :system do
  let(:buyer) { create(:buyer, email: buyer_email) }
  let(:buyer_email) { "user#{rand(100)}@example.com" }

  before do
    create(:admin_user, email: 'admin@example.com', password: 'password')
    create(:rfp, start_year: 2021, bid_type: 'Produce')
    create(:district_profile, buyer: buyer, district_name: 'New District')
  end

  it 'allows admin to view documents and configure scores', :js do
    visit admin_root_path
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: 'password'

    click_on 'Log in'

    expect(page).to have_content('Signed in successfully')

    within 'nav' do
      click_on 'Admin Users'
    end

    expect(page).to have_content('admin@example.com')

    within 'nav' do
      click_on 'Rfps'
    end

    expect(page).to have_content('2021')

    click_on 'Produce'
    expect(page).to have_content('Produce')
    click_on 'Edit'
    page.attach_file('rfp_item_list', 'spec/fixtures/files/item_list.txt')

    click_on 'Update Rfp'
    expect(page).to have_content('item_list.txt')

    within 'nav' do
      click_on 'District Profiles'
    end
    expect(page).to have_content('New District')
    click_on 'New District'
    expect(page).to have_content('New District')

    click_on 'Edit New District'
    fill_in 'Full name', with: 'ContactName'
    click_on 'Update District profile'
    expect(page).to have_content('ContactName')

    within 'nav' do
      click_on 'Buyers'
    end

    expect(page).to have_content(buyer_email)

    click_on buyer_email

    expect(page).to have_content(buyer_email)

    click_on 'New District'

    expect(page).to have_content('New District')

    click_on 'Score Categories'
    click_on 'New score category'

    fill_in 'Name', with: 'My Category'
    fill_in 'Description', with: 'This is the category description'
    fill_in 'Position', with: '1'

    click_on 'Create Score category'
    expect(page).to have_content('My Category')
  end
end
