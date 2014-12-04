class TodosController < ApplicationController

  def new
    @todo = Todo.new
  end

  def index
    @todos = Todo.where(user_id: current_user)
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to todos_path, notice: "Your new TODO was saved"
    else
      redirect_to new_todo_path, alert: "There was an error saving your todo: #{@todo.errors.full_messages.first}"
    end
  end

  def destroy
    @todo = Todo.find params[:id]
    if @todo.destroy
      redirect_to todos_path, notice: "Todo deleted successfully"
    else
      redirect_to new_todo_path, alert: "There was an error deleting your todo: #{@todo.errors.full_messages.first}"
    end
  end

  def show
    @todo = Todo.find params[:id]
  end

  private

  def todo_params
    params.require(:todo).permit(:description)
  end

end