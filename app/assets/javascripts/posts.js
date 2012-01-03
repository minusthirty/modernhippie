function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".image").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("ul#images").append(content.replace(regexp, new_id));
}

// home page cover image rollover
$(function(){
  $("#posts li a").hover(function(){
    $("img", this).stop().animate({left:"-245px"},{queue:false,duration:400});
  }, function() {
    $("img", this).stop().animate({left:"0px"},{queue:false,duration:300});
  });
});