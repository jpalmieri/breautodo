require 'rails_helper'

feature 'User updates list', js: true do
  let!(:user) { create(:user) }
  let!(:first_list) { create(:list, user: user) }
  let!(:second_list) { build(:list, user: user, name: 'some other list') }
  let(:blank_name_error) { "There was an error saving your list: Name can't be blank" }

  before { sign_in(user) }

  scenario 'successfully: update name' do
    within find('#lists tr:last-child') do
      click_link 'Edit'
    end

    fill_in "Name", with: "updated list"
    click_button 'Submit'

    expect(current_path).to eq(lists_path)
    # updated list is first
    expect( find('#lists tr:nth-child(2)') ).to have_content('updated list')
  end

  scenario 'successfully: with new todo' do
    within find('#lists tr:last-child td.name') do
      click_link first_list.name
    end

    fill_in 'Description', with: "new todo"
    within(:css, 'form.add-todo') do
      click_button '+'
    end

    expect(current_path).to eq(list_path first_list)
    click_link "Lists"

    # updated list is first
    expect( find('#lists tr:nth-child(2)') ).to have_content(first_list.name)
  end

  scenario 'Unsuccessfully: no name' do
    within find('#lists tr:last-child') do
      click_link 'Edit'
    end
    fill_in "Name", with: ""
    click_button 'Submit'

    expect(current_path).to eq(edit_list_path 1)
    expect( page ).to have_content(blank_name_error)
  end
end
