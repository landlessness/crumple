$(document).ready(function(){
  $('.auto-link').each(function(index) {
    $(this).attr('title',$(this).attr('href'));
    $(this).tipsy({gravity: 's'});
  });
});
