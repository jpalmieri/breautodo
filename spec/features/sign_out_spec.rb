require 'rails_helper'

describe "Sign out flow" do

  describe "successfully" do
    it "redirects to the welcome index (root)" do
      authenticated_user
  
      within '.user-info' do
        click_link 'Sign out'
      end

      expect(current_path).to eq root_path
    end
  end
end