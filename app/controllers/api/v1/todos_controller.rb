class Api::V1::TodosController < Api::ApiController

  def destroy
    user = User.find_by_auth_token(request.headers["Authorization"])
    if user
      Todo.find(params[:id]).destroy
      head :no_content
    else
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

end
