require 'rails_helper'

feature 'User creates todos', js: true do

  before do
    user = create(:user)
    sign_in(user)
    list = create(:list, user: user)
    visit list_path 1

    fill_in 'Description', with: 'first todo'
    within(:css, 'form.add-todo') do
      click_button '+'
    end

    fill_in 'Description', with: 'second todo'
    within(:css, 'form.add-todo') do
      click_button '+'
    end
  end

  scenario "successfully" do

    expect(current_path).to eq(list_path 1)
    expect( page ).to have_css(
      '#todos tr:first-child', text: 'second todo')
    expect( page ).to have_css(
      '#todos tr:last-child', text: 'first todo')
  end

  scenario 'Unsuccessfully: no description' do
    message = AlertConfirmer.get_alert_text_from do
      within(:css, 'form.add-todo') do
        click_button '+'
      end
    end

    expect( message ).to eq("There was an error: No Description")
  end
end
