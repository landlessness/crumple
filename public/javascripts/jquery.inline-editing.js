$(document).ready(function(){
  initInlineEditBindings();
})
function initInlineEditBindings() {
  $('.edit-comment-link').click(function () {
    comment = $(this).parents('.comment')
    comment_editor = comment.prev('.edit-comment');
    comment.hide();
    comment_editor.show();
    comment_editor.find('#comment_body').focus();
    resize();
    $(function() {$('.resize-textarea').autogrow();});
    return false;
  })
  $('.cancel-edit-comment-link').click(function () {
    comment_editor = $(this).parents('.edit-comment');
    comment = comment_editor.next('.comment')
    comment.show();
    comment_editor.hide();
    resize();
    return false;
  })
  $('.select-project-link').click(function () {
    project = $(this).parents('.project')
    project_editor = project.prev('.edit-project');
    project.hide();
    project_editor.show();
    project_editor.find('#thought_project_id').focus();
    return false;
  })
  $('.cancel-select-project-link').click(function () {
    project_editor = $(this).parents('.edit-project');
    project = project_editor.next('.project')
    project.show();
    project_editor.hide();
    resize();
    return false;
  })
  $('.edit_thought_project_select').change(function() {
    form = $(this).parents('.edit_thought_project')
    form.submit();
  });
}