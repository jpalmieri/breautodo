require 'rails_helper'

feature 'User signs up' do

  before do
    visit root_path
    within '.user-info' do
      click_link 'Sign Up'
    end
    fill_in 'Name', with: "Robert Paulson"
    @valid_email = "robertpaulson@example.com"
    @invalid_email = "robertpaulson@example"
    @valid_password = "hellowworld"
    @invalid_password = "1234567"
  end

  scenario 'Successfully' do
    fill_in 'Email', with: @valid_email
    fill_in 'Password', with: @valid_password
    fill_in 'Password confirmation',with: @valid_password
    
    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq root_path
    expect( page ).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')
  end

  scenario "Password too short" do
    fill_in 'Email', with: @valid_email
    fill_in 'Password', with: @invalid_password
    fill_in 'Password confirmation', with: @invalid_password

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq user_registration_path
    expect( page ).to have_content("1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)")
  end

  scenario "Invalid email" do
    fill_in 'Email', with: @invalid_email
    fill_in 'Password', with: @valid_password
    fill_in 'Password confirmation', with: @valid_password

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq user_registration_path
    expect( page ).to have_content("1 error prohibited this user from being saved: Email is invalid")
  end
 
end