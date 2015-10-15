---
---
$ ->
  $('#about').hover ->
    $("#bg").toggleClass("hover-effect")
    # $("#overlay").css( "background-color", "#26A65B" )

  $('#work').hover ->
    $("#bg3").toggleClass("hover-effect")

  $('#blog').hover ->
    $("#bg4").toggleClass("hover-effect")

  $('#contact').hover ->
    $("#bg5").toggleClass("hover-effect")


  $('#about').click (ev) ->
    ev.preventDefault()
    $("#bg").addClass("active-effect")
    $(".site-header").css({ top: '0px' })
    $(".page").removeClass("active")
    $("#about-page").addClass("active")
    

  $('#work').click (ev) ->
    ev.preventDefault()
    $("#bg3").addClass("active-effect")
    $(".site-header").css({ top: '0px' })
    $(".page").removeClass("active")
    $("#work-page").addClass("active")

  $('#blog').click (ev) ->
    ev.preventDefault()
    $("#bg4").addClass("active-effect")
    $(".site-header").css({ top: '0px' })
    $(".page").removeClass("active")
    $("#blog-page").addClass("active")

  $('#contact').click (ev) ->
    ev.preventDefault()
    $("#bg5").addClass("active-effect")
    $(".site-header").css({ top: '0px' })
    $(".page").removeClass("active")
    $("#contact-page").addClass("active")



  $('.home-link').click (ev) ->
    ev.preventDefault()
    $(".site-header").css({ top: '52px' })
    $(".page").removeClass("active")
    $(".bg").removeClass("active-effect")
    




    

