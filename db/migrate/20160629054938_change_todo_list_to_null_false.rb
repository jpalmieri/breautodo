class ChangeTodoListToNullFalse < ActiveRecord::Migration
  def change
    change_column_null :todos, :list_id, false
  end
end
