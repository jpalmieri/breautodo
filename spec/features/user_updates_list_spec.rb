require 'rails_helper'

feature 'User updates list', js: true do

  before do
    user = create(:user)
    list1 = create(:list, user: user, name: 'List one')
    list2 = create(:list, user: user, name: 'List two')
    list3 = create(:list, user: user, name: 'List three')
    sign_in(user)
  end

  scenario 'successfully' do
    within find('#lists tr:last-child') do
      click_button('Edit')
    end
    fill_in "Name", with: "updated list"
    click_button 'Submit'

    expect(current_path).to eq(lists_path)
    # updated list is first
    expect( find('#lists tr:first-child') ).to have_content('updated list')
  end
end
