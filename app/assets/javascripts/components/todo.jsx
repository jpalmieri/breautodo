var Todo = React.createClass({
  render: function() {
    return (
      <tr>
        <td className='description'>{this.props.todo.description}</td>
        <td>
          <input type="submit" data-delete-todo-button="true" data-todo-id={this.props.todo.id} value="–" />
        </td>
      </tr>
    )
  }
})
