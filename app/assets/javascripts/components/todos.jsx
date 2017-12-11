var Todos = React.createClass({
  render: function() {
    return (
      <table className="todos">
        <tbody>
          {this.props.todos.map(function(todo) {
            return (
              <Todo todo={todo} />
            )
          })}
        </tbody>
      </table>
    )
  }
});
