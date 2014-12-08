require 'rails_helper'

describe "Sign in flow" do

  describe "successful" do
    it "redirects to the todo index" do
      authenticated_user

      expect(current_path).to eq todos_path
    end
  end
end