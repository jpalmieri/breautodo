require 'rails_helper'

describe ListsController do
  include Devise::TestHelpers

  let!(:signed_in_user)  { create(:user) }
  let!(:other_user)      { create(:user) }
  let(:accessible_list)  { create(:list, user: signed_in_user) }
  let(:other_users_list) { create(:list, user: other_user) }

  before { sign_in signed_in_user }

  describe '#destroy' do
    it "allows a user to delete own list" do
      delete :destroy, { id: accessible_list.id }
      is_expected.to redirect_to lists_url
      is_expected.to set_the_flash.to('List deleted successfully')
    end

    it "does not allow a user to delete another user's list" do
      delete :destroy, { id: other_users_list.id }
      is_expected.to redirect_to root_url
      is_expected.to set_the_flash.to('There was an error deleting your list. You are not authorized to delete this list.')
    end

  end

end
