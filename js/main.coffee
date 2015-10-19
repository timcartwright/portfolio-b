---
---
$ ->

  #Get the name of the page
  re = new RegExp("{{ site.baseurl }}\\/?([\\w\\-\\.]+)\\/?")
  page = re.exec(location.pathname)

  #Make sure content is visible if page is not the homepage
  if page
    $('#one').addClass 'active'
    $('#bg-' + page[1]).addClass 'active-effect'
    $('.site-header').css top: '0px'
    $('#home-nav').css display: 'none'
    $('#top-nav').delay(1300).fadeIn 10

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
      # Get the first element of the pathname
      re = new RegExp("{{ site.baseurl }}\\/?([\\w\\-\\.]+)\\/?")
      page = re.exec(location.pathname)
      # Put the new content into hidden div
      $('#two').html $(data).find('#one').html()
      console.log(page)
      if page
        # If valid page or not homepage
        # If a page is active already then toggle active and hidden divs
        if $('#one').hasClass('active')
          $('#one').toggleClass 'active'
          $('#two').toggleClass 'active'
        else
          $('#two').addClass 'active'
        # Swap the div ids 
        $('#one').attr 'id', 'temp'
        $('#two').attr 'id', 'one'
        $('#temp').attr 'id', 'two'
        # Transition effects
        $('.bg').removeClass 'active-effect'
        $('#bg-' + page[1]).addClass 'active-effect'
        $('.site-header').css top: '0px'
        $('#home-nav').fadeOut 10
        $('#top-nav').delay(1300).fadeIn 10
        $("body").className = ""
        $("body").addClass page
        #Clear contents of previous page
        $('#two').delay(800).queue (n) ->
          $(this).html("")
          n()
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

    
  
  