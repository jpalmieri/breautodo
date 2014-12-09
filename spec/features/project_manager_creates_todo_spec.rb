require 'rails_helper'

feature 'Project manager creates TODO' do

  before do
    user = create(:user)
    sign_in(user)
  end

  scenario 'Successfully' do
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
