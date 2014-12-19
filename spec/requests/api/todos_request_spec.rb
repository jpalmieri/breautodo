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

    it "prevents anonymous attacker from deleting" do
      user = create(:user)
      todo = create(:todo, user: user)
      
      delete "/api/v1/todos/#{todo.id}", {}, "Authorization" => "made-up-token"

      expect(response.status).to eq(401)
      expect(json[:message]).to eq("Unauthorized")
      expect(response.content_type).to eq("application/json")
    end

    xit "prevents logged in attacker from deleting others todos" do

    end

    xit "respond with 404 for unknown todo id" do
    end

    private

    def json
      JSON.parse(response.body, symbolize_names: true)
    end

  end

end