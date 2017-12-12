var TodoList = React.createClass({
  listEditLink: function() {
    return (
      `/lists/${this.props.list.id}/edit`
    )
  },
  render: function() {
    return (
      <div>
        <table id='header'>
          <tbody>
            <tr>
              <th><h3 className='caps-header'>{this.props.list.name}</h3></th>
              <th><a className="btn" href={this.listEditLink()}>Edit</a></th>
            </tr>
          </tbody>
        </table>
        <TodoForm list={this.props.list} />
        <Todos todos={this.props.todos} />
      </div>
    )
  }
});
