require 'spec_helper'
require 'rails_helper'

feature 'session user', %q{
  sign in
  sign up
  sign out
 } do

  given(:user) { create(:user) }

  scenario "Existing user try to sign in" do
    sign_in user

    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Non-existing user try to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345'
    click_on 'Log in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

  scenario 'render views sign up' do
    visit questions_path
    click_on 'sign up'

    expect(current_path).to eq new_user_registration_path
  end

  scenario 'sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
    expect(page).to have_content 'wrong@user.com'
  end

  scenario 'sign up, Invalid' do
    visit new_user_registration_path

    fill_in 'Email', with: ''
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: ''

    click_on 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password is too short (minimum is 8 characters)"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end


  scenario 'sign out' do
    sign_in(user)

    visit questions_path

    click_on 'sign_out'

    expect(page).to have_content 'Signed out successfully.'
  end
end