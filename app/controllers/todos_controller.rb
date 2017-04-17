class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = current_user.todos.newest
    authorize @todos
  end

  def create
    @todo = current_user.todos.create(todo_params)
    authorize @todo
    if @todo.persisted?
      redirect_to todos_path, notice: "Your new TODO was saved"
    else
      flash[:error] = "There was an error saving your todo: #{@todo.errors.full_messages.first}"
      redirect_to todos_path
    end
  end

  def destroy
    @todo = current_user.todos.find params[:id]
    authorize @todo
    if @todo.destroy
      redirect_to todos_path, notice: "Todo deleted successfully"
    else
      flash[:error] = "There was an error deleting your todo. Please try again."
      redirect_to todos_path
    end
  end

  private

  def todo_params
    todo_params = params.require(:todo).permit(:description)
    todo_params[:description].strip!
  end

  def tags_from_description(description)
    tag_regex = /(?:|^)(?:#(?!.\d+(?:\s|$)))(\w+)(?=\s|$)/i
    description.scan(tag_regex).flatten
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:error] = "There was an error deleting your todo. You are not authorized to delete this todo."
    redirect_to root_path
  end

end
