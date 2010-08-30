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
}