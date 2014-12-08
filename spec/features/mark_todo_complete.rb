require 'rails_helper'

feature "Delete todo item" do
  
  scenario "successfully" do

    authenticate_user

    visit new_todo_path
    fill_in 'Description', with: "Buy groceries"
    click_button 'Save'

    click_link 'Delete'

    expect( page ).to_not have_content("Buy groceries")
    expect( page ).to have_content("Todo deleted successfully")
  end
end


