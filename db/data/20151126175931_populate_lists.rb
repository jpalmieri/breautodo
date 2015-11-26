class PopulateLists < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      initial_list = List.create(name: "New List", user: user)
      user.todos.each do |todo|
        todo.list_id = initial_list.id
        todo.save!
      end
    end
  end

  def self.down
    raise IrreversibleMigration
  end
end
