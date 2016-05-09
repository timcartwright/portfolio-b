---
---
$ ->

  pageName = -> #Get the name of the page
    re = new RegExp("{{ site.baseurl }}\\/?([\\w\\-\\.]+)\\/?")
    return re.exec(location.pathname)

  swapDivs = (a,b) -> #swap the ids of two divs
    $("#"+a).attr 'id', 'temp'
    $("#"+b).attr 'id', a
    $('#temp').attr 'id', b

  isPost = (page) -> #is the page a post or work item?
    (page[1] == "work" && location.pathname != "{{ site.baseurl }}work/") || 
    (page[1] == "blog" && location.pathname != "{{ site.baseurl }}blog/")

  isParent = (page) -> #are we moving from a post to it's parent?
    (page[1] == "work" || "blog") && $('#three').hasClass('active')

  emptyContents = (element) -> #clear contents of element with delay
    $(element).delay(800).queue ->
    $(this).html("") 

  transitionToNormalPage = -> #animate page transitions
    $('#one').addClass 'active'
    $('#bg-' + page[1]).addClass 'active-effect'
    $('.site-header').css top: '0px'
    $('#home-nav').fadeOut 10
    $('#top-nav').delay(1300).fadeIn 10
    $('.bg').removeClass 'active-effect'
    $("body").className = ""
    $("body").addClass page

  transitionToHomePage = -> #animate page transition to home
    $('.site-header').css top: '52px'
    $('.page').removeClass 'active'
    $('.bg').removeClass 'active-effect'
    $('#home-nav').delay(900).fadeIn 10
    $('#top-nav').fadeOut 10
    $("body").className = ""
    $("body").addClass "home"

  pageLogic = (data) ->
    if page # If valid page or not homepage
      if isPost(page)      
         # Put the new content into hidden div
         $('#three').html $(data).find('#one').html()
         $('#three').addClass 'active'
         emptyContents ('#one')      
       else if isParent(page)  #if is parent of post
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
         swapDivs('one', 'two')
         transitionToNormalPage()
         emptyContents ('#two')
     else # If homepage or invalid page
       transitionToHomePage()
       emptyContents('one')
       emptyContents('two')
    
  #Normal page load here
  page = pageName()
  if page
    if isPost(page)
      # Put the new content into hidden div     
      $('#three').html $('#one').html()
      $('#three').addClass 'active'
      emptyContents('#one')
     
    transitionToNormalPage()

  #Background hover effects      
{% for page in site.pages %}
  {% if (page.class) %}
  $("nav .{{ page.title | downcase }}").hover ->
    $("#bg-{{ page.title | downcase }}").toggleClass("hover-effect")
    $("body").toggleClass("{{ page.class }}")
  {% endif %}
{% endfor %}

  #Ajax page transitions start here, modified from http://www.builtinbruges.com/2014/08/using-ajax-content-in-jekyll-updated-for-universal-analytics/
  siteUrl = 'http://'+(document.location.hostname||document.location.host)

  $(document).delegate 'a[href^="/"],a[href^="' + siteUrl + '"]', 'click', (e) ->
    e.preventDefault()
    History.pushState {}, '', @pathname

  # Catch all History stateChange events
  History.Adapter.bind window, 'statechange', ->
    state = History.getState()
    # Load the new state's URL via an Ajax Call
    $.get state.url, (data) ->
      # Replace the "<title>" tag's content
      document.title = $(data).find('title').text()     
      page = pageName()
      pageLogic(data)



    

    
  
  