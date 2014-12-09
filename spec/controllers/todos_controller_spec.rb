require 'rails_helper'

describe TodosController do

  include Devise::TestHelpers

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @todo = create(:todo, user: @user1)
    sign_in @user2
  end

  describe '#destroy' do
    it "allows a user to delete own todo" do
      expect {
        delete :destroy, { id: @todo.id }
        }.to_not raise_error
    end

    it "does not allow a users to delete another user's todo" do
      expect {
        delete :destroy, { id: @todo.id }
        }.to raise_error
    end

  end

end