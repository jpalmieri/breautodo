require 'rails_helper'

feature 'User updates list', js: true do

  before do
    user = create(:user)
    @list1 = create(:list, user: user, name: 'List one')
    @list2 = create(:list, user: user, name: 'List two')
    @list3 = create(:list, user: user, name: 'List three')
    sign_in(user)
  end

  scenario 'successfully: update name' do
    within find('#lists tr:last-child') do
      click_button('Edit')
    end
    fill_in "Name", with: "updated list"
    click_button 'Submit'

    expect(current_path).to eq(lists_path)
    # updated list is first
    expect( find('#lists tr:first-child') ).to have_content('updated list')
  end

  scenario 'successfully: with new todo' do
    within find('#lists tr:last-child td.name') do
      click_link @list1.name
    end

    fill_in 'Description', with: "new todo"
    click_button 'Add Todo'

    expect(current_path).to eq(list_path @list1)
    click_link "Lists"

    # updated list is first
    expect( find('#lists tr:first-child') ).to have_content(@list1.name)
  end

  scenario 'Unsuccessfully: no name' do
    within find('#lists tr:last-child') do
      click_button('Edit')
    end
    fill_in "Name", with: ""
    click_button 'Submit'

    expect(current_path).to eq(edit_list_path 1)
    expect( page ).to have_content("There was an error saving your list: Name can't be blank")
  end
end
