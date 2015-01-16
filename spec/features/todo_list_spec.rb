require 'rails_helper'

feature "View multiple todo items", js: true do

  before do
    user = create(:user)
    sign_in(user)

    fill_in 'Description', with: "Buy groceries"
    click_button 'Add Todo'

    fill_in 'Description', with: "Get haircut"
    click_button 'Add Todo'
  end

  scenario "successfully" do

    expect(current_path).to eq(todos_path)

    expect( page ).to have_content("Buy groceries")
    expect( page ).to have_content("Get haircut")
  end

  scenario "without seeing '0' in 'days left' column" do
    Timecop.freeze(Time.now + 6.5.days) do
      visit todos_path
      expect( first('.days-left') ).to_not have_content("0")
    end
  end
end