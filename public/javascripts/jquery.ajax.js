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
    comment = $(this).parents('.comment');
    spinner = comment.prev('.loading');
    
    comment.css('visibility', 'hidden');
    spinner.show();
  };

  var completed_deleting_comment = function() { 
    spinner = $(this).parents('.comment').prev('.loading');
    spinner.hide();
  };

  $(".delete_comment")
    .bind("ajax:loading",  deleting_comment)
    .bind("ajax:complete", completed_deleting_comment);

  var editing_comment = function() { 
    comment_editor = $(this).parents('.edit-comment');
    spinner = comment_editor.prev('.loading');

    comment_editor.css('visibility', 'hidden');
    spinner.show();
  };

  var completed_editing_comment = function() { 
    comment_editor = $(this).parents('.edit-comment');
    comment = comment_editor.next('.comment');
    spinner = comment_editor.prev('.loading');
    
    comment_editor.css('visibility', 'visible');
    comment_editor.hide();
    spinner.hide();
    comment.show();
    resize();
  };

  $(".edit_comment")
    .bind("ajax:loading",  editing_comment)
    .bind("ajax:complete", completed_editing_comment);

});