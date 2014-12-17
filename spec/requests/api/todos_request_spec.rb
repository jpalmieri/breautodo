require "rails_helper"

describe "Todos API" do

  context "DELETE destroy" do

    it "should delete a todo" do
      user = create(:user)
      todo = create(:todo, user: user)
      
      delete "/api/v1/todos/#{todo.id}", {}, "Authorization" => user.auth_token

      expect(response.status).to eq(204)
      # http://httpstatus.es :created, :no_content
      expect(Todo.count).to eq(0)
    end

    xit "should ensure a user is authenticated" do
    end

    xit "prevents attackers from deleting others todos" do
    end

    xit "respond with 404 for unknown todo id" do
    end

  end

end