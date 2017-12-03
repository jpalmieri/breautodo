require 'rails_helper'
require 'rake'

def reset_demo_app
  load File.expand_path("../../../lib/tasks/reset_demo_app.rake", __FILE__)
  Rake::Task.define_task(:environment)
  Rake::Task["reset_demo_app"].invoke
end

def create_list_with_todo(user)
  list = create(:list, user: user)
  create(:todo, list: list)
end

describe "reset_demo_app rake task" do
  before do
    ENV['DEMO'] = 'true'
    @demo_user = create(:user, email: 'demo@example.com')
    @user = create(:user)
    [@demo_user, @user].each { |user| create_list_with_todo(user) }
  end

  it "destroys lists and users after 30 minutes" do
    Timecop.freeze(Time.now + 30.minutes) do
      reset_demo_app
      expect( @demo_user.lists.first ).to be_nil
      expect( User.where(email: @user.email) ).to be_empty
    end
  end

  it "does not destroy list and users before 30 minutes" do
    Timecop.freeze(Time.now + 29.minutes) do
      reset_demo_app
      expect( @demo_user.lists.first ).to_not be_nil
      expect( @demo_user.lists.first.todos.first ).to_not be_nil
      expect( User.where(email: @user.email) ).to_not be_empty
    end
  end
end
