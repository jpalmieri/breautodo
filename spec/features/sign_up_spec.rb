require 'rails_helper'

feature 'User signs up' do
  let(:valid_email)      { 'robertpaulson@example.com' }
  let(:invalid_email)    { 'robertpaulson@example' }
  let(:valid_password)   { 'hellowworld' }
  let(:invalid_password) { '1234567' }

  before do
    visit new_user_session_path
    within 'form' do
      click_link 'Sign up'
    end
    fill_in 'Name', with: 'Robert Paulson'
  end

  scenario 'Successfully' do
    fill_in 'Email', with: valid_email
    fill_in 'Password', with: valid_password
    fill_in 'Password confirmation',with: valid_password

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq new_user_session_path
    expect( page ).to have_content('A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.')

    open_email(valid_email)
    expect(current_email).to have_body_text('You can confirm your account email through the link below:')
    click_first_link_in_email

    expect( page ).to have_content('Your email address has been successfully confirmed.')
    expect(page).to have_content('Sign in')

    fill_in 'user_email', with: valid_email
    fill_in 'Password', with: valid_password

    within 'form' do
      click_button 'Sign in'
    end

    expect(page).to have_content('Signed in successfully.')
  end

  scenario 'Password too short' do
    fill_in 'Email', with: valid_email
    fill_in 'Password', with: invalid_password
    fill_in 'Password confirmation', with: invalid_password

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq user_registration_path
    expect( page ).to have_content('1 error prohibited this user from being saved: Password is too short (minimum is 8 characters)')
  end

  scenario 'Invalid email' do
    fill_in 'Email', with: invalid_email
    fill_in 'Password', with: valid_password
    fill_in 'Password confirmation', with: valid_password

    within 'form' do
      click_button 'Sign up'
    end

    expect(current_path).to eq user_registration_path
    expect( page ).to have_content('1 error prohibited this user from being saved: Email is invalid')
  end

end
