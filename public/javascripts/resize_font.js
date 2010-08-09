$(document).ready(function(){
  if ($('#thought_body').length) {
    $(window).resize(resize);
    resize();
  }
});

function resize() {
  var newFontSize =  Math.floor((($('#thought_body').width() - 6.3799) / 25.407));  
  // if (newFontSize<10) {newFontSize=10;}
  $('#thought_body').css('font-size', newFontSize)
}

// Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.