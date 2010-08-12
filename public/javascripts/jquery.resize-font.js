$(document).ready(function(){
  if ($('.resize-font').length) {
    $(window).resize(resize);
    resize();
  }
});

function resize() {
  var sizeCoefficient = 1.0;
  var newFontSize = Math.floor(sizeCoefficient * (0.0394 * $('.resize-font').width() + 0.2489))
  $('.resize-font').css('font-size', newFontSize)
}

// copy/paste for testing
// Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.  