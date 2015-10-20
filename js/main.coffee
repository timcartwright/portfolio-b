---
---
$ ->

  page_name = -> #Get the name of the page
    re = new RegExp("{{ site.baseurl }}\\/?([\\w\\-\\.]+)\\/?")
    return re.exec(location.pathname)

  swap_div_ids = (a,b) -> #swap the ids of two divs
    $("#"+a).attr 'id', 'temp'
    $("#"+b).attr 'id', a
    $('#temp').attr 'id', b

  is_post = (page) ->
    (page[1] == "work" && location.pathname != "{{ site.baseurl }}work/") || (page[1] == "blog" && location.pathname != "{{ site.baseurl }}blog/")

  empty_contents = (element) -> #clear contents of element with delay
    $(element).delay(800).queue (n) ->
    $(this).html("")
    n()

  transition_for_normal_page = ->
    $('#one').addClass 'active'
    $('#bg-' + page[1]).addClass 'active-effect'
    $('.site-header').css top: '0px'
    $('#home-nav').css display: 'none'
    $('#top-nav').delay(1300).fadeIn 10
    
  #Make sure content is visible if page is not the homepage
  page = page_name()
  if page
    if is_post(page)
      # Put the new content into hidden div     
      $('#three').html $('#one').html()
      $('#three').addClass 'active'
      $('#one').html ""
     
    transition_for_normal_page()

    

  #Background hover effects      
{% for page in site.pages %}
  {% if (page.class) %}
  $("nav .{{ page.title | downcase }}").hover ->
    $("#bg-{{ page.title | downcase }}").toggleClass("hover-effect")
    $("body").toggleClass("{{ page.class }}")
  {% endif %}
{% endfor %}


  #Ajax page load, modified from http://www.builtinbruges.com/2014/08/using-ajax-content-in-jekyll-updated-for-universal-analytics/
  siteUrl = 'http://'+(document.location.hostname||document.location.host)

  $(document).delegate 'a[href^="/"],a[href^="' + siteUrl + '"]', 'click', (e) ->
    e.preventDefault()
    History.pushState {}, '', @pathname

  # Catch all History stateChange events
  History.Adapter.bind window, 'statechange', ->
    State = History.getState()
    # Load the new state's URL via an Ajax Call
    $.get State.url, (data) ->
      # Replace the "<title>" tag's content
      document.title = $(data).find('title').text()
      
      page = page_name()
      if page # If valid page or not homepage
  
        if is_post(page)
      
          # Put the new content into hidden div
          $('#three').html $(data).find('#one').html()
          $('#three').addClass 'active'
          #Clear contents of previous page after the transition effect
          empty_contents ('#one')
          
          
        else if (page[1] == "work" || "blog") && $('#three').hasClass('active') #if moving the blog/work index from post/work item
          $('#one').html $(data).find('#one').html()
          $('#three').removeClass 'active'

        else
          $('#three').removeClass 'active'
          # Put the new content into hidden div
          $('#two').html $(data).find('#one').html()
          
          if $('#one').hasClass('active') # If a page is active already then toggle active and hidden divs
            $('#one').toggleClass 'active'
            $('#two').toggleClass 'active'
          else
            $('#two').addClass 'active'
          # Swap the div ids 
          swap_div_ids('one', 'two')
          # Transition effects
          $('.bg').removeClass 'active-effect'
          $('#bg-' + page[1]).addClass 'active-effect'
          $('.site-header').css top: '0px'
          $('#home-nav').fadeOut 10
          $('#top-nav').delay(1300).fadeIn 10
          $("body").className = ""
          $("body").addClass page
          #Clear contents of previous page
          empty_contents ('#two')
      else
        # If homepage or invalid page
        $('.site-header').css top: '52px'
        $('.page').removeClass 'active'
        $('.bg').removeClass 'active-effect'
        $('#home-nav').delay(900).fadeIn 10
        $('#top-nav').fadeOut 10
        $("body").className = ""
        $("body").addClass "home"
        #Clear contents of previous page
        $('#two').delay(800).queue (n) ->
          $(this).html("")
          $('#one').html("")
          n()

    
  
  