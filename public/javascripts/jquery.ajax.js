$(document).ready(function(){
  initAjaxBindings();
})

function initAjaxBindings() {
  $("#new_comment")
    .bind("ajax:loading",  loading_new_comment)
    .bind("ajax:complete", complete_new_comment);
  $(".delete_comment")
    .bind("ajax:loading",  deleting_comment)
    .bind("ajax:complete", completed_deleting_comment);
  $(".edit_comment")
    .bind("ajax:loading",  editing_comment)
    .bind("ajax:complete", completed_editing_comment);
  $(".edit_thought_project")
    .bind("ajax:loading",  editing_project)
    .bind("ajax:complete", completed_editing_project);
}

function loading_new_comment() { 
  $("#new_comment_loading").show();
  $('.editing').css('visibility', 'hidden');
};

function complete_new_comment() { 
  $("#new_comment_loading").hide();
  $('.editing').css('visibility', 'visible');
  resize();
};

function deleting_comment() { 
  comment = $(this).parents('.comment');
  spinner = comment.prev('.edit-comment').prev('.loading');

  comment.css('visibility', 'hidden');
  spinner.show();
};

function completed_deleting_comment() { 
  comment = $(this).parents('.comment');
  spinner = comment.prev('.edit-comment').prev('.loading');
  spinner.hide();
};

function editing_comment() { 
  comment_editor = $(this).parents('.edit-comment');
  spinner = comment_editor.prev('.loading');

  comment_editor.css('visibility', 'hidden');
  spinner.show();
};

function completed_editing_comment() { 
  comment_editor = $(this).parents('.edit-comment');
  comment = comment_editor.next('.comment');
  spinner = comment_editor.prev('.loading');
    
  comment_editor.css('visibility', 'visible');
  comment_editor.hide();
  spinner.hide();
  comment.show();
  resize();
};

function editing_project() {
  project_editor = $(this).parents('.edit-project');
  spinner = project_editor.prev('.loading');

  project_editor.css('visibility', 'hidden');
  spinner.show();
};

function completed_editing_project() { 
  project_editor = $(this).parents('.edit-project');
  project = project_editor.next('.project');
  spinner = project_editor.prev('.loading');
    
  project_editor.css('visibility', 'visible');
  project_editor.hide();
  spinner.hide();
  project.show();
  resize();
};
