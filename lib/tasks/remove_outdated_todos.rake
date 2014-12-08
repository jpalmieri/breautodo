task delete_items: :environment do
  expired_todos = Todo.where("created_at < ?", Time.now - 7.days)
  expired_todos.each &:destroy
end