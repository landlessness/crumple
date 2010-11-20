$(document).ready(function(){
  initInlineEditBindings();
});
function initInlineEditBindings() {
  $('#thoughts_show').find('.edit-thought-link').click(function () {
    $('#thoughts_show').hide();
    thought_editor = $('#thoughts_edit').show();
    thought_editor.find('#thought_body').focus();
    resize();
    $(function() {$('.resize-textarea').autogrow();});
    return false;
  });
  $('#thoughts_edit').find('.cancel-edit-thought-link').click(function () {
    $('#thoughts_edit').hide();
    $('#thoughts_show').show();
    resize();
    return false;
  });
  $('.edit-comment-link').click(function () {
    comment = $(this).parents('.comment');
    comment_editor = comment.prev('.edit-comment');
    comment.hide();
    comment_editor.show();
    comment_editor.find('#comment_body').focus();
    resize();
    $(function() {$('.resize-textarea').autogrow();});
    return false;
  });
  $('.cancel-edit-comment-link').click(function () {
    comment_editor = $(this).parents('.edit-comment');
    comment = comment_editor.next('.comment');
    comment.show();
    comment_editor.hide();
    resize();
    return false;
  });
  $('.add-tags-link').click(function () {
    tags = $(this).parents('.tags');
    tags_adder = tags.find('.add-tags');
    add_tags_link_container = tags.find('.add-tags-link-container');
    add_tags_link_container.hide();
    tags_adder.show();
    tags_adder.find('#thought_tags_list_concat').focus();
    return false;
  });
  $('.cancel-add-tags-link').click(function () {
    tags = $(this).parents('.tags');
    tags_adder = tags.find('.add-tags');
    add_tags_link_container = tags.find('.add-tags-link-container');    
    add_tags_link_container.show();
    tags_adder.hide();
    return false;
  });
  $('.select-project-link').click(function () {
    project = $(this).parents('.project');
    project_editor = project.prev('.edit-project');
    project.hide();
    project_editor.show();
    project_editor.find('#thought_project_id').focus();
    return false;
  });
  $('.cancel-select-project-link').click(function () {
    project_editor = $(this).parents('.edit-project');
    project = project_editor.next('.project');
    project.show();
    project_editor.hide();
    resize();
    return false;
  });
  $('.edit_thought_project_select').change(function() {
    form = $(this).parents('.edit_thought_project');
    form.submit();
  });
}