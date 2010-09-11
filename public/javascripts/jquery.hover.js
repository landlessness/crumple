$(document).ready(function(){
  initHoverBindings();
})

function initHoverBindings() {
  $('.tagging-container').hover(
    function () {
      $(this).find('.super-subtle-delete-action').css('visibility', 'visible');
    },
    function () {
      $(this).find('.super-subtle-delete-action').css('visibility','hidden');
    }
  );
}