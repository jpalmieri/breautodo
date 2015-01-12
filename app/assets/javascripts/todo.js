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
      todoRow.html('<div class="alert alert-success">Todo deleted successfully</div>').fadeOut(1000);
    };

    $.ajax(ajaxOptions).done(removeTodoFromDOM).fail(handleError);
  };

  function setupTodoDeleteHandlers() {
    $(document).on("click", "[data-delete-todo-button]", deleteTodo);
  };
  setupTodoDeleteHandlers();

})(jQuery);