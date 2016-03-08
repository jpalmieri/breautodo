require 'rails_helper'

describe ListsController do

  include Devise::TestHelpers

  before do
    @user1 = create(:user)
    @user2 = create(:user)
    @list = create(:list, user: @user1)
  end

  describe '#destroy' do
    it "allows a user to delete own list" do
      sign_in @user1
      delete :destroy, { id: @list.id }
      should redirect_to lists_url
      should set_the_flash.to("List deleted successfully")
    end
  end

end
