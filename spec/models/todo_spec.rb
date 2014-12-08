require 'rails_helper'
require 'rake'

describe Todo do
  
  before do
    @user = create(:user)
    @todo = create(:todo, user: @user)
  end

  describe "#days_left" do

    it "counts the number of days until a new todo is destroyed" do
      expect( @todo.days_left.round ).to eq(7)
    end

  end

  context "delete_items rake task" do
    it "destroys todo after 7 days" do
      Timecop.freeze(Time.now + 7.days) do
        #load and execute custom rake task
        load File.expand_path("../../../lib/tasks/remove_outdated_todos.rake", __FILE__)
        Rake::Task.define_task(:environment)
        Rake::Task["delete_items"].invoke

        expect( @user.todos.first ).to be_nil
      end
    end

    it "does not destroy todo after 6 days" do
      Timecop.freeze(Time.now + 6.days) do
        #load and execute custom rake task
        load File.expand_path("../../../lib/tasks/remove_outdated_todos.rake", __FILE__)
        Rake::Task.define_task(:environment)
        Rake::Task["delete_items"].invoke

        expect( @user.todos.first ).to_not be_nil
      end
    end
  end
end