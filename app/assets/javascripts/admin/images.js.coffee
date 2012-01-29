class ImageField
  @remove: (link) ->
    $(link).prev("input[type=hidden]").val("1")
    $(link).closest(".image").hide()

  @add: (association, content) ->
    new_id = new Date().getTime()
    regexp = new RegExp "new_#{association}", "g"
    $("table#images tbody").append(content.replace(regexp, new_id))

# @ === window, exports ImageField class to global
@.ImageField = ImageField