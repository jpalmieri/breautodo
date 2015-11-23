require 'rails_helper'

describe "Sign out flow" do

  describe "successfully" do
    it "redirects to the welcome index (root)" do
      user = create(:user)
      sign_in(user)

      within '.nav' do
        click_button 'Sign out'
      end

      expect(current_path).to eq new_user_session_path
      expect(page).to have_css(".nav", text: "Sign In")
      expect(page).to_not have_css(".user-email")
    end
  end
end
