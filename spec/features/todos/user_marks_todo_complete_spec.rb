require 'rails_helper'

feature 'Delete todo item', js: true do
  let(:user) { create(:user) }
  let(:list) { create(:list, user: user) }

  before do
    sign_in(user)
    visit list_path(list)
  end

  scenario 'successfully' do
    fill_in 'Description', with: 'Buy groceries'
    within(:css, 'form.add-todo') do
      click_button '+'
    end

    expect( page ).to have_content('Buy groceries')
    click_button '–'
    expect( page ).to_not have_content('Buy groceries')
  end
end


