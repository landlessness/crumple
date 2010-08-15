$(document).ready(function(){
  $('.auto-link').each(function(index) {
    $(this).attr('title',wordwrap($(this).attr('href'),35,null,true));
    $(this).tipsy({gravity: 's'});
  });
});

function wordwrap( str, width, brk, cut ) {
    brk = brk || '\n';
    width = width || 75;
    cut = cut || false;
    if (!str) { return str; }
    var regex = '.{1,' +width+ '}(\\s|$)' + (cut ? '|.{' +width+ '}|.+$' : '|\\S+?(\\s|$)');
    return str.match( RegExp(regex, 'g') ).join( brk );
}