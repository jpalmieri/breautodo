require 'rails_helper'

describe "Sign in flow" do

  describe "successful" do
    it "redirects to the todo index" do
      sign_in

      expect(current_path).to eq todos_path
      expect(page).to_not have_css(".user-info", text: "Sign In")
      expect(page).to have_css(".user-email")
    end
  end
end