$(document).ready(function(){
  initFlashMessageBindings();
})
function initFlashMessageBindings() {
  $('.close-flash-message-link').click(function () {
    $('#flash_container').hide();
    return false;
  })
}