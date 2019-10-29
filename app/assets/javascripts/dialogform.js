$( document ).on('turbolinks:load', function() {
  $("#dialog-1").dialog({
    autoOpen: false,
  });
  $("#opener").click(function() {
    $("#dialog-1").dialog("open");
  });
});
