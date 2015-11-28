class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
    authorize @lists
  end

end
