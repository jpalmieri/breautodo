require 'rails_helper'

describe "Sign in flow" do

  include TestModules

  describe "successful" do
    it "redirects to the todo index" do
      
      capy_sign_in

      expect(current_path).to eq todos_path
    end
  end
end