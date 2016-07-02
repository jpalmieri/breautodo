require 'rails_helper'

feature 'User creates lists', js: true do
  let!(:user) { create(:user) }
  let(:first_list) { build(:list) }
  let(:second_list) { build(:list, name: 'some other list') }
  let(:third_list) { build(:list, name: 'another list') }
  let(:all_lists) { [first_list, second_list, third_list] }

  def create_list(list)
    visit lists_path
    click_link 'new-list-button'
    fill_in 'Name', with: list.name
    click_button 'Submit'
  end

  before { sign_in(user) }

  scenario 'successfully' do
    create_list(first_list)
    expect(current_path).to eq(list_path 1)
    expect( page ).to have_content(/#{first_list.name}/i)

    create_list(second_list)
    create_list(third_list)
    visit lists_path
    all_lists.each do |l|
      expect( page ).to have_content(/#{l.name}/i)
    end
  end

  scenario 'Unsuccessfully: no description' do
    visit new_list_path
    click_button 'Submit'

    expect(current_path).to eq(lists_path)
    expect( page ).to have_content("There was an error saving your list: Name can't be blank")
  end
end
