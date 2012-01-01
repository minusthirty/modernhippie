function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".image").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("ul#images").append(content.replace(regexp, new_id));
}
