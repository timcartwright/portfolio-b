---
---

$ ->
  $('#about').hover ->
    $("#bg").toggleClass("hover-effect")

  $('#work').hover ->
    $("#bg3").toggleClass("hover-effect")


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

  $('.home-link').click (ev) ->
    ev.preventDefault()
    $(".site-header").css({ top: '52px' })
    $(".page").removeClass("active")
    $(".bg").removeClass("active-effect")
    




    

