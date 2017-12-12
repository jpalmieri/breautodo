var Todos = React.createClass({
  renderTodos: function() {
    if (this.props.todos.length == 0) {
      return (
        <div id="no-todos">
          Enter a description of your todo in the box above.
        </div>
      )
    } else {
      return (
        this.props.todos.map(function(todo) {
          return (
            <Todo todo={todo} />
          )
        })
      )
    }
  },
  render: function() {
    return (
      <table className="todos">
        <tbody>
          {this.renderTodos()}
        </tbody>
      </table>
    )
  }
});
