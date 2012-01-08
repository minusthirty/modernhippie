
// home page cover image rollover
$(function(){
  $("#posts li a").hover(function(){
    $("img", this).stop().animate({left:"-245px"},{queue:false,duration:400});
  }, function() {
    $("img", this).stop().animate({left:"0px"},{queue:false,duration:300});
  });
});