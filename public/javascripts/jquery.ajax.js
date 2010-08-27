jQuery(function($) {
  // create a convenient toggleLoading function
  var toggleLoading = function() { $("#loading").toggle() };

  $("#new_comment")
    .bind("ajax:loading",  toggleLoading)
    .bind("ajax:complete", toggleLoading);
});