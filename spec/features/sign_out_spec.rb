require 'rails_helper'

describe "Sign out flow" do

  describe "successfully" do
    it "redirects to the welcome index (root)" do
      user = create(:user)
      visit root_path

      within '.user-info' do
        click_link 'Sign In'
      end
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Sign in'
      end
  
      within '.user-info' do
        click_link 'Sign out'
      end

      expect(current_path).to eq root_path
    end
  end
end