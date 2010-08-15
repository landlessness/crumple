$(document).ready(function(){
  $('.auto-link').each(function(index) {
    // $(this).attr('title',wordwrap($(this).attr('href'),55 ,'<br/>',true));
    $(this).attr('title',$(this).attr('href'));
    $(this).tipsy({gravity: 's',fade: false, html: true});
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