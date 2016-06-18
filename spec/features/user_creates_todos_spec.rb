require 'rails_helper'

feature 'User creates todos', js: true do

  before do
    user = create(:user)
    sign_in(user)
    list = create(:list, user: user)
    visit list_path 1

    fill_in 'Description', with: "Buy groceries"
    click_button 'Add Todo'

    fill_in 'Description', with: "Get haircut"
    click_button 'Add Todo'
  end

  scenario "successfully" do

    expect(current_path).to eq(list_path 1)

    expect( page ).to have_content("Buy groceries")
    expect( page ).to have_content("Get haircut")
  end

  scenario 'Unsuccessfully: no description' do
    message = AlertConfirmer.get_alert_text_from do
      click_button 'Add Todo'
    end

    expect( message ).to eq("There was an error: No Description")
  end
end
