require 'rails_helper'
require 'rake'

def remove_outdated_todos
  load File.expand_path("../../../lib/tasks/remove_outdated_todos.rake", __FILE__)
  Rake::Task.define_task(:environment)
  Rake::Task["delete_items"].invoke 
end

describe "delete_items rake task" do
  before do
    @user = create(:user)
    create(:todo, user: @user)
  end

  it "destroys todo after 7 days" do
    Timecop.freeze(Time.now + 7.days) do
      remove_outdated_todos      
      expect( @user.todos.first ).to be_nil
    end
  end

  it "does not destroy todo after 6 days" do
    Timecop.freeze(Time.now + 6.days) do
      remove_outdated_todos
      expect( @user.todos.first ).to_not be_nil
    end
  end
end