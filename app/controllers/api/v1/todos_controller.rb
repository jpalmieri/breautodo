class Api::V1::TodosController < ApplicationController

  def destroy
    Todo.find(params[:id]).destroy
    head :no_content

  end

end
