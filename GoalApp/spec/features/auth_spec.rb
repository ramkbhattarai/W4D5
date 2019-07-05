require 'spec_helper'
require 'rails_helper'

feature 'the signup process', type: :feature do
  scenario 'has a new user page' do
    visit new_user_url
    save_and_open_page
    expect(page).to have_content("Welcome!")
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      user = build(:user)
     sign_up_user(user)
     save_and_open_page
     expect(page).to have_content("#{user.username}")
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    visit new_session_url
    user = create(:user)
    log_in_user(user)
    save_and_open_page
    expect(page).to have_content("#{user.username}")
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    
  end

  scenario 'doesn\'t show username on the homepage after logout'

end