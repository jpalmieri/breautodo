require 'rails_helper'

feature "Delete todo item", js: true do

  scenario "successfully" do
    user = create(:user)
    sign_in(user)

    fill_in 'Description', with: "Buy groceries"
    click_button 'Add Todo'

    expect( page ).to have_content("Buy groceries")

    click_button 'Delete'

    expect( page ).to_not have_content("Buy groceries")
  end
end


