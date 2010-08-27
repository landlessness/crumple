jQuery(function($) {
  // create a convenient toggleLoading function
  var loading = function() { 
    $(".loading").toggle();
    $('.editing').css('visibility', 'hidden');
  };

  var complete = function() { 
    $(".loading").toggle();
    $('.editing').css('visibility', 'visible');
    resize();
  };

  $("#new_comment")
    .bind("ajax:loading",  loading)
    .bind("ajax:complete", complete);
});