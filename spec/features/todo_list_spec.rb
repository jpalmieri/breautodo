require 'rails_helper'

feature "View multiple todo items" do
  scenario "successfilly" do
    user = create(:user)
    sign_in(user)

    visit new_todo_path
    fill_in 'Description', with: "Buy groceries"
    click_button 'Save'

    visit new_todo_path
    fill_in 'Description', with: "Get haircut"
    click_button 'Save'

    expect(current_path).to eq(todos_path)

    expect( page ).to have_content("Buy groceries")
    expect( page ).to have_content("Get haircut")
  end
end