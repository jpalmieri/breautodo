require 'rails_helper'

feature 'User signs out' do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe 'successfully' do
    it 'redirects to the welcome index (root)' do
      within '.nav' do
        click_button 'Sign out'
      end

      expect(current_path).to eq new_user_session_path
      expect(page).to have_css('.nav', text: 'Sign In')
      expect(page).to_not have_css('.user-email')
    end
  end
end
