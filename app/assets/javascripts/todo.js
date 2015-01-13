(function($) {

  function handleError(error) {
    // Relies on error response from API being JSON object like:
    // { errors: [ "Error message", "Another error message" ] }
    var errorsObj = $.parseJSON(error.responseText)
    var errorMessages = errorsObj.errors;
    alert("There was an error: " + errorMessages);
  };

  function getAuthToken() {
    // meta tag in <head> holds auth token
    // <meta name="auth-token" content="TOKEN GOES HERE">
    var authToken = $("meta[name=auth-token]").attr("content");
    return authToken;
  };

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
      var todoRow = clickedElement.closest("tr");
      todoRow.fadeOut("normal", function() { $(this).remove(); });
    };

    $.ajax(ajaxOptions).done(removeTodoFromDOM).fail(handleError);
  };

  function addTodoToDOM(data) {
    var todoId = data.todo.id;
    var deleteButton = '<a class="btn btn-success" data-delete-todo-button="true" data-todo-id="' + todoId + '" href="javascript:void(0);">Delete</a>'
    var daysLeft = '7';
    var todosTable = $("#todos");
    var lastRowNumber = todosTable.find('tbody tr:last-child').find('td').html()
    var rowNumber = parseInt(lastRowNumber) + 1;
    var tableRow = '<tr><td>' + rowNumber + '</td><td>' + data.todo.description + '</td><td>' + daysLeft + '</td><td>' + deleteButton + '</td></tr>';
    
    todosTable.append(tableRow);
    todosTable.show();
  };

  function clearForm() {
    //clear input field
    var descriptionInput = $("#todo_description");
    descriptionInput.val("");
  };

  function createTodo(event) {
    event.preventDefault();

    var descriptionInput = $("#todo_description");
    var description = descriptionInput.val();
    var todo = { "description": description };

    var ajaxOptions = {
      type: "POST",
      headers: { "Authorization": getAuthToken() },
      url: "/api/v1/todos",
      dataType: "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(todo)
    };

    $.ajax(ajaxOptions).done([clearForm, addTodoToDOM]).fail(handleError);
  };

  function setupTodoHandlers() {
    $(document).on("click", "[data-delete-todo-button]", deleteTodo);
    $(document).on("click", "[data-create-todo-button]", createTodo);
  };
  setupTodoHandlers();

})(jQuery);