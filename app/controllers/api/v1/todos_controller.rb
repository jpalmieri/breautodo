class Api::V1::TodosController < Api::ApiController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  def create
    user = User.find_by_auth_token(request.headers["Authorization"])
    description = params[:description]

    if description.length < 5
      render json: {errors: "Description too short"}, status: :not_acceptable
    elsif user
      todo = user.todos.create(description: description)
      render json: TodoSerializer.new(todo).to_json, status: :created
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  def index
    user = User.find_by_auth_token(request.headers["Authorization"])

    if !user
      render json: {message: "Unauthorized"}, status: :unauthorized
    else
      todos = user.todos
      render json: todos, each_serializer: TodoSerializer, status: :ok
    end
  end

  def destroy
    todo = Todo.find(params[:id])
    user = User.find_by_auth_token(request.headers["Authorization"])

    if !user
      render json: {message: "Unauthorized"}, status: :unauthorized
    elsif user != todo.user
      render json: {message: "Forbidden"}, status: :forbidden
    else
      todo.destroy
      head :no_content
    end
  end

  private

  def not_found_response
    render json: {message: "Not Found"}, status: :not_found
  end

end
