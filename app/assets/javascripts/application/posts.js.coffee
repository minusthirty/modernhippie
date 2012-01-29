$ ->
  $postList = $("ul#posts")
  $postList.isotope
    itemSelector : 'li.post'
  
  # nav select class
  $('a.filter').click ->
    $('a.filter').removeClass 'selected'
    $(this).addClass 'selected'
    
    $postList.isotope 
      filter: $(this).attr 'data-filter'
    false

  # home page rollover slider
  $("#posts li a").hover (->
    $("img", this).stop().animate
      left: "-245px"
    ,
      queue: false
      duration: 400
  ), ->
    $("img", this).stop().animate
      left: "0px"
    ,
      queue: false
      duration: 300