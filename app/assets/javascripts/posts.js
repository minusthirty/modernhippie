function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".attachment").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("table#attachments tbody").append(content.replace(regexp, new_id));
}


$(function(){

  // isotope setup
  var $container = $('#container');

  // isotope setup
  $container.isotope({
    itemSelector: '.item',
    layoutMode: 'cellsByRow',
    cellsByRow: {
      columnWidth: 240,
      rowHeight: 360
    }
  });


  // filter items when filter link is clicked
  $('#filters li a').click(function(){
    var selector = $(this).attr('data-filter');
    $container.isotope({ filter: selector });
    return false;
  });
});