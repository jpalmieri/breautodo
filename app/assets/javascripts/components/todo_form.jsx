var TodoForm = React.createClass({
  render: function() {
    return (
      <form className="add-todo">
        <input autoFocus='true' placeholder="Description" className="add-description" type="text" name="todo[description]" id="todo_description" />
        <input type="submit" name="commit" value="+" className="add-todo-button" />
      </form>
    )
  }
});
