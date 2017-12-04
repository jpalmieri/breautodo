require 'rails_helper'

describe 'User creates todos', js: true do
  let!(:user) { create(:user) }
  let!(:list) { create(:list, user: user) }

  before do
    sign_in(user)
    visit list_path(list)

    fill_in 'Description', with: 'first todo'
    within(:css, 'form.add-todo') do
      click_button '+'
    end

    fill_in 'Description', with: 'second todo'
    within(:css, 'form.add-todo') do
      click_button '+'
    end
  end

  scenario 'successfully' do
    expect(current_path).to eq(list_path list)
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

    expect( message ).to eq('There was an error: No Description')
  end
end
