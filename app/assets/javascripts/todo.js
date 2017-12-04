(function($) {

  function handleError(error) {
    // Relies on error response from API being JSON object like:
    // { errors: [ "Error message", "Another error message" ] }
    var errorsObj = $.parseJSON(error.responseText);
    var errorMessages = errorsObj.errors;
    alert("There was an error: " + errorMessages);
  }

  function getAuthToken() {
    // meta tag in <head> holds auth token
    // <meta name="auth-token" content="TOKEN GOES HERE">
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  }

  function deleteTodo(event) {
    event.preventDefault();

    // Get the delete button that was clicked (event.target) and
    // wrap it in a jQuery object.
    var clickedElement = $(event.target);

    // The delete button needs a data-todo-id attribute, e.g.
    // <button data-todo-id="7" data-delete-todo-button="true">Delete</button>
    var todoId = clickedElement.data("todo-id");

    var ajaxOptions = {
      type: "DELETE",
      headers: { "Authorization": getAuthToken() },
      url: "/api/v1/todos/" + todoId,
      dataType: "json",
      contentType: "application/json; charset=utf-8"
    };

    function removeTodoFromDOM() {
      // Assumes that the delete button is a child element of the
      // todo's table row.
      clickedElement.blur();
      var todoRow = clickedElement.closest("tr");
      var rowNumber = todoRow.find('td').html();
      todoRow.fadeOut("normal", function() { $(this).remove(); });
    }



    $.ajax(ajaxOptions).done(removeTodoFromDOM).fail(handleError);
  }

  function addTodoToDOM(data) {
    var todoId = data.todo.id;
    var deleteButton = '<input type="submit" data-delete-todo-button="true" data-todo-id="' + todoId + '" value="–">';
    var todosTable = $("#todos");
    var tableRow = '<tr><td class="description">' + data.todo.description + '</td><td>' + deleteButton + '</td></tr>';

    todosTable.prepend(tableRow);
    todosTable.show();
    $('#no-todos').remove();
  }

  function clearForm() {
    //clear input field
    var descriptionInput = $("#todo_description");
    descriptionInput.val("");
  }

  function createTodo(event) {
    event.preventDefault();
    event.target.blur()

    var descriptionInput = $("#todo_description");
    var description = descriptionInput.val();
    var listId = $(event.target).find('.add-todo-button').data('list-id');
    var todo = { "description": description, 'list_id': listId };

    var ajaxOptions = {
      type: "POST",
      headers: { "Authorization": getAuthToken() },
      url: "/api/v1/todos",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(todo)
    };

    $.ajax(ajaxOptions).done([clearForm, addTodoToDOM]).fail(handleError);
  }

  function setupTodoHandlers() {
    $(document).on("click", "[data-delete-todo-button]", deleteTodo);
    $(document).on("submit", ".add-todo", createTodo);
  }
  setupTodoHandlers();

})(jQuery);
