require 'rails_helper'

describe TodosController do

  include Devise::TestHelpers

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @todo = create(:todo, user: @user1)
  end

  describe '#destroy' do
    it "allows a user to delete own todo" do
      sign_in @user1
      delete :destroy, { id: @todo.id }
      should redirect_to todos_url
      should set_the_flash.to("Todo deleted successfully")
    end

    it "does not allow a user to delete another user's todo" do
      sign_in @user2
      delete :destroy, { id: @todo.id }
      should redirect_to root_url
      should set_the_flash.to("There was an error deleting your todo. You are not authorized to delete this todo.")
    end

  end

end
