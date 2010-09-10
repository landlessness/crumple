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
  $(".add_thought_tags")
    .bind("ajax:loading",  adding_tags)
    .bind("ajax:complete", completed_adding_tags);
  $(".edit_thought")
    .bind("ajax:loading",  editing_thought)
    .bind("ajax:complete", completed_editing_thought);
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

function adding_tags() {
  tag_adder = $(this).parents('.add-tags');
  spinner = tag_adder.prev('.loading');

  tag_adder.css('visibility', 'hidden');
  spinner.show();
};

function completed_adding_tags() { 
  tags = $(this).parents('.tags');
  add_tags_link_container = tags.find('.add-tags-link-container');
  tag_adder = tags.find('.add-tags');
  spinner = tag_adder.prev('.loading');
  
  add_tags_link_container.show();
  tag_adder.css('visibility', 'visible');
  tags.find('#thought_tags_list_concat').val('');
  tag_adder.hide();
  spinner.hide();
};

function editing_thought() { 
  thought_editor = $('#thoughts_edit');
  spinner = thought_editor.prev().prev('.loading');

  thought_editor.css('visibility', 'hidden');
  spinner.show();
};

function completed_editing_thought() { 
  thought_editor = $('#thoughts_edit');
  spinner = thought_editor.prev().prev('.loading');

  $('#thoughts_show').show();
  thought_editor.css('visibility', 'visible');
  thought_editor.hide();
  spinner.hide();  
  resize();
};
