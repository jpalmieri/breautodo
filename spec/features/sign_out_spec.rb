require 'rails_helper'

describe "Sign out flow" do

  include TestModules

  describe "successfully" do
    it "redirects to the welcome index (root)" do
      capy_sign_in
  
      within '.user-info' do
        click_link 'Sign out'
      end

      expect(current_path).to eq root_path
    end
  end
end