class AddListRefToTodos < ActiveRecord::Migration
  def change
    add_reference :todos, :list, index: true, foreign_key: true
  end
end
