class RemoveDaysLeftFromTodos < ActiveRecord::Migration
  def change
    remove_column(:todos, :days_left)
  end
end
