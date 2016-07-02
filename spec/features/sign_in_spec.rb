require 'rails_helper'

feature 'User signs in' do
  let(:user) { create(:user) }
  before { sign_in(user) }

  describe 'successful' do
    it 'redirects to the todo index' do
      expect(current_path).to eq lists_path
      expect(page).to_not have_css(".nav", text: "Sign In")
      expect(page).to have_css(".nav", text: user.email)
    end
  end
end
