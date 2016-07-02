require "rails_helper"

describe "Todos API" do

  context "DELETE destroy" do

    it "deletes a todo" do
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

  end

  context "POST create" do
    before { @user = create(:user) }

    context 'without a list id' do
      it "responds with a nil list error" do
        post "/api/v1/todos", {description: "Finish Breautodo"}, "Authorization" => @user.auth_token

        expect(response.status).to eq(406)
        expect(json[:errors]).to eq("No List")
        expect(response.content_type).to eq("application/json")
        expect(Todo.count).to eq(0)
      end
    end

    context 'with a list id' do
      before { @list = create(:list) }

      it "creates a todo associated with that list" do
        post "/api/v1/todos", {description: "Finish Breautodo", list_id: @list.id}, "Authorization" => @user.auth_token

        expect(response.status).to eq(201)
        expect(json[:todo][:id]).to eq(Todo.last.id)
        expect(json[:todo][:description]).to eq("Finish Breautodo")
        expect(json[:todo][:list_id]).to eq(@list.id)
        expect(Todo.count).to eq(1)
      end
    end

    it "prevents anonymous attacker from creating" do
      user = create(:user)
      list = create(:list)

      post "/api/v1/todos", {description: "Finish Breautodo", list_id: list.id}, "Authorization" => "fake-token"

      expect(response.status).to eq(401)
      expect(json[:message]).to eq("Unauthorized")
      expect(response.content_type).to eq("application/json")
      expect(Todo.count).to eq(0)
    end

  end

  context "GET index" do

    it "shows a list of todos" do
      user = create(:user)
      todo1 = create(:todo, user: user)
      todo2 = create(:todo, user: user)

      get "/api/v1/todos", {}, "Authorization" => user.auth_token

      expect(response.status).to eq(200)
      expect(json[:todos][0][:id]).to eq(todo1.id)
      expect(json[:todos][0][:description]).to eq(todo1.description)
      expect(json[:todos][1][:id]).to eq(todo2.id)
      expect(json[:todos][1][:description]).to eq(todo2.description)
      expect(response.content_type).to eq("application/json")
    end

    it "prevents an anonymous user from seeing a list of todos" do
      user = create(:user)
      todo1 = create(:todo, user: user)
      todo2 = create(:todo, user: user)

      get "/api/v1/todos", "Authorization" => "fake-token"

      expect(response.status).to eq(401)
      expect(json[:message]).to eq("Unauthorized")
      expect(response.content_type).to eq("application/json")
    end

  end

  private

  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end
