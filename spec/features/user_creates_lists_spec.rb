require 'rails_helper'

feature 'User creates list', js: true do

  before do
    user = create(:user)
    sign_in(user)
    click_link 'New List'
  end

  scenario 'successfully' do
    fill_in 'Name', with: 'Fancy new list'
    click_button 'Submit'

    expect(current_path).to eq(list_path 1)
    expect( page ).to have_content(/Fancy new list/i)
  end

  scenario 'Unsuccessfully: no description' do
    click_button 'Submit'

    expect(current_path).to eq(lists_path)
    expect( page ).to have_content("There was an error saving your list: Name can't be blank")
  end
end
