class AddListToTodos < ActiveRecord::Migration
  def self.up
    users_with_todos = User.joins(:todos).uniq.all

    users_with_todos.each do |user|
      todos_from_deleted_lists = []
      user.todos.each do |todo|
        begin
          List.find(todo.list_id)
        rescue ActiveRecord::RecordNotFound => e
          todos_from_deleted_lists << todo
        end
      end

      orphan_todos = todos_from_deleted_lists + user.todos.where(list_id: nil)

      unless orphan_todos.empty?
        orphan_todo_list = List.create(user: user, name: 'Orphan todos')
        orphan_todos.each { |t| t.update(list_id: orphan_todo_list.id) }
      end
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
