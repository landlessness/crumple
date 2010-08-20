$(document).ready(function(){
  if ($('.resize-font').length) {
    $(window).resize(resize);
    resize();
  }
});

function resize() {
  var sizeCoefficient = 1.0;
  var minSize = 16;
  $('.resize-font').each(function(index) {
    var newFontSize = Math.floor(sizeCoefficient * (0.0394 * $(this).width() + 0.2489));
    if (newFontSize < minSize) {newFontSize = minSize};
    $(this).css('font-size', newFontSize);
  });    
}
