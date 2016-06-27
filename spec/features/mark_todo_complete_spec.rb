require 'rails_helper'

feature "Delete todo item", js: true do

  scenario "successfully" do
    user = create(:user)
    sign_in(user)
    list = create(:list, user: user)
    visit list_path 1

    fill_in 'Description', with: "Buy groceries"
    within(:css, 'form.add-todo') do
      click_button '+'
    end

    expect( page ).to have_content("Buy groceries")

    click_button '–'

    expect( page ).to_not have_content("Buy groceries")
  end
end


