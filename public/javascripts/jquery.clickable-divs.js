$(document).ready(function(){
  $(".list-thoughts .list-thought").click(function(){
    window.location=$(this).find("a").attr("href"); return false;
  });
  $(".list-thoughts .list-thought").hover(
    function () {
      $(this).addClass('list-thought-hover');
    }, 
    function () {
      $(this).removeClass('list-thought-hover');
    }
  );
});