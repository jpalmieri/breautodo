class ListsController < ApplicationController
  before_action :authenticate_user!

  def index
    @lists = current_user.lists
    authorize @lists
    @lists = @lists.sort_by(&:updated_at).reverse!
  end

  def show
    @list = current_user.lists.find params[:id]
    authorize @list
    @todos = @list.todos
  end

  def new
    @list = current_user.lists.new
  end

  def create
    @list = current_user.lists.create(list_params)
    authorize @list
    if @list.persisted?
      redirect_to list_path(@list.id), notice: "Your new list was saved"
    else
      flash[:error] = "There was an error saving your list: #{@list.errors.full_messages.first}"
      redirect_to lists_path
    end
  end

  def edit
    @list = current_user.lists.find params[:id]
    authorize @list
  end

  def update
    @list = current_user.lists.find params[:id]
    authorize @list
    if @list.update_attributes(list_params)
      redirect_to lists_path, notice: "Your list was updated"
    else
      flash[:error] = "There was an error saving your list: #{@list.errors.full_messages.first}"
      redirect_to edit_list_path @list
    end
  end

  def destroy
    @list = current_user.lists.find params[:id]
    authorize @list
    if @list.destroy
      redirect_to lists_path, notice: "List deleted successfully"
    else
      flash[:error] = "There was an error deleting your list. Please try again."
      redirect_to lists_path
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = "There was an error deleting your list. You are not authorized to delete this list."
    redirect_to root_path
  end

end
