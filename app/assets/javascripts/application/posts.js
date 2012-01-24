

// home page cover image rollover
$(function(){
  var $postList = $("ul#posts");

  // initialize isotope
  $postList.isotope({
    itemSelector : 'li.post'
  });
  
  // filter items when filter link is clicked
  $('a.filter').click(function(){
    $('a.filter').removeClass('selected');
    $(this).addClass('selected');
    
    var selector = $(this).attr('data-filter');
    $postList.isotope({ filter: selector });
    return false;
  });
  
  // slider
  $("#posts li a").hover(function(){
    $("img", this).stop().animate({left:"-245px"},{queue:false,duration:400});
  }, function() {
    $("img", this).stop().animate({left:"0px"},{queue:false,duration:300});
  });
});





