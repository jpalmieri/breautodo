require 'rails_helper'

describe TodosController do
  include Devise::TestHelpers

  let!(:signed_in_user)  { create(:user) }
  let!(:other_user)      { create(:user) }
  let(:accessible_todo)  { create(:todo, user: signed_in_user) }
  let(:other_users_todo) { create(:todo, user: other_user) }

  before { sign_in signed_in_user }

  describe '#destroy' do
    it 'allows a user to delete own todo' do
      delete :destroy, { id: accessible_todo.id }
      is_expected.to redirect_to todos_url
      is_expected.to set_flash.to('Todo deleted successfully')
    end

    it "does not allow a user to delete another user's todo" do
      delete :destroy, { id: other_users_todo.id }
      is_expected.to redirect_to root_url
      is_expected.to set_flash.to('There was an error deleting your todo. You are not authorized to delete this todo.')
    end

  end

end
