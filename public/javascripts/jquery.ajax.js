jQuery(function($) {
  var loading_new_comment = function() { 
    $("#new_comment_loading").show();
    $('.editing').css('visibility', 'hidden');
  };

  var complete_new_comment = function() { 
    $("#new_comment_loading").hide();
    $('.editing').css('visibility', 'visible');
    resize();
  };

  $("#new_comment")
    .bind("ajax:loading",  loading_new_comment)
    .bind("ajax:complete", complete_new_comment);

  var deleting_comment = function() { 
    comment = $(this).parent().parent().parent().parent();
    spinner = comment.prev();
    
    spinner.show();
    comment.css('visibility', 'hidden');
  };

  var completed_deleting_comment = function() { 
    spinner = $(this).parent().parent().parent().parent().prev();
    spinner.hide();
  };

  $(".delete_comment")
    .bind("ajax:loading",  deleting_comment)
    .bind("ajax:complete", completed_deleting_comment);
});