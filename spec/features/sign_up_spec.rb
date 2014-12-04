require 'rails_helper'

feature 'User signs up' do

  before do
    visit root_path
    within '.user-info' do
      click_link 'Sign Up'
    end
  end

  scenario 'Successfully' do

    fill_in 'Name', with: "Robert Paulson"
    fill_in 'Email', with: "robertpaulson@example.com"
    fill_in 'Password', with: "helloworld"
    fill_in 'Password confirmation',with: "helloworld"
    
    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq root_path
    expect( page ).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end

  scenario "unsuccessfully" do

    fill_in 'Name', with: "Robert Paulson"
    fill_in 'Email', with: "robertpaulson@example.com"
    fill_in 'Password', with: "1234567"
    fill_in 'Password confirmation', with: "1234567"

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq user_registration_path
    expect( page ).to have_content("1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)")
  end
 
end