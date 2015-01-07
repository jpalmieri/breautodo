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
      expect(Todo.count).to eq(1)
    end

    it "prevents logged in attacker from deleting others todos" do
      victim = create(:user)
      todo = create(:todo, user: victim)
      attacker = create(:user)

      delete "/api/v1/todos/#{todo.id}", {}, "Authorization" => attacker.auth_token

      expect(response.status).to eq(403)
      expect(json[:message]).to eq("Forbidden")
      expect(response.content_type).to eq("application/json")
      expect(Todo.count).to eq(1)
    end

    it "respond with 404 for unknown todo id" do
      user = create(:user)

      delete "/api/v1/todos/999", {}, "Authorization" => user.auth_token

      expect(response.status).to eq(404)
      expect(json[:message]).to eq("Not Found")
      expect(response.content_type).to eq("application/json")
    end

    private

    def json
      JSON.parse(response.body, symbolize_names: true)
    end

  end

end