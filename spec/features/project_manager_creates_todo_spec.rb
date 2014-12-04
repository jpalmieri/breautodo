require 'rails_helper'

feature 'Project manager creates TODO' do
  scenario 'Successfully' do
    user = create(:user)
    visit root_path

    within '.user-info' do
      click_link 'Sign In'
    end
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    within 'form' do
      click_button 'Sign in'
    end

    visit new_todo_path
    fill_in 'Description', with: 'Meet up with the team'
    click_button 'Save'

    expect( page ).to have_content('Your new TODO was saved')
    expect( page ).to have_content('Meet up with the team')
  end

  scenario 'Unsuccessfully: no description' do
    visit new_todo_path
    click_button 'Save'
    expect( page ).to have_content("There was an error saving your todo: Description is too short (minimum is 5 characters)")
  end
end
