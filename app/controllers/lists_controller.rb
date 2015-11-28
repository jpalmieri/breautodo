class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
    authorize @lists
  end

  def show
    @list = current_user.lists.find params[:id]
    authorize @list
    @todos = @list.todos
  end

end
