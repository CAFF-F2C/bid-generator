require 'rails_helper'

RSpec.describe 'Buyer signs up', type: :system do
  it 'creates an account', :js do
    visit root_path

    expect(page).to have_content('Sign into your account')
    expect(page).to be_axe_clean

    click_on 'create an account'

    expect(page).to have_content('Create your account')
    expect(page).to be_axe_clean

    fill_in 'Full name', with: 'Buyer Name'
    fill_in 'Email', with: 'buyer@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_on 'Sign up'

    expect(page).to have_content(/confirmation link/i)

    open_email 'buyer@example.com'
    current_email.click_link('Confirm my account')

    click_on 'Log in'

    fill_in 'Email', with: 'buyer@example.com'
    fill_in 'Password', with: 'password'

    click_on 'Log in'

    expect(page).to have_content(/my documents/i)
    click_on 'Sign out'
    expect(page).to have_content(/log in/i)
  end
end
