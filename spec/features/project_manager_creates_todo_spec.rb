require 'rails_helper'

feature 'Project manager creates TODO', js: true do

  before do
    user = create(:user)
    sign_in(user)
  end

  scenario 'Successfully' do
    fill_in 'Description', with: 'Meet up with the team'
    click_button 'Add Todo'

    expect( page ).to have_content('Meet up with the team')
  end

  scenario 'Unsuccessfully: no description' do
    
    message = AlertConfirmer.get_alert_text_from do
      click_button 'Add Todo'
    end

    expect( message ).to eq("There was an error: Description too short")

  end
end
