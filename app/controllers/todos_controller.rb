class TodosController < ApplicationController
  before_action :authenticate_user!

  def new
    @todo = Todo.new
    authorize @todo
  end

  def index
    @todos = current_user.todos
    authorize @todos
  end

  def create
    @todo = current_user.todos.create(todo_params)
    authorize @todo
    if @todo.persisted?
      redirect_to todos_path, notice: "Your new TODO was saved"
    else
      flash[:error] = "There was an error saving your todo: #{@todo.errors.full_messages.first}"
      redirect_to new_todo_path
    end
  end

  def destroy
    @todo = Todo.find params[:id]
    authorize @todo
    if @todo.destroy
      redirect_to todos_path, notice: "Todo deleted successfully"
    else
      flash[:error] = "There was an error deleting your todo. Please try again."
      redirect_to new_todo_path
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end

end