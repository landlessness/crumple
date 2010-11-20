$(document).ready(function(){
  initInlineEditBindings();
});
function initInlineEditBindings() {
  $('.tab').click(function () {
    $('.thought-form').hide();
    $('.active-tab').hide();
    $('.subtle-tab').show();
    $(this).children('.active-tab').show();
    $(this).children('.subtle-tab').hide();
    $('#tab-' + $(this).attr('data_add_on_id')).show();
    return false;
  });  
}