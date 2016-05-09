(function() {
  $(function() {
    var emptyContents, isParent, isPost, page, pageLogic, pageName, siteUrl, swapDivs, transitionToHomePage, transitionToNormalPage;
    pageName = function() {
      var re;
      re = new RegExp("/portfolio-b/\\/?([\\w\\-\\.]+)\\/?");
      return re.exec(location.pathname);
    };
    swapDivs = function(a, b) {
      $("#" + a).attr('id', 'temp');
      $("#" + b).attr('id', a);
      return $('#temp').attr('id', b);
    };
    isPost = function(page) {
      return (page[1] === "work" && location.pathname !== "/portfolio-b/work/") || (page[1] === "blog" && location.pathname !== "/portfolio-b/blog/");
    };
    isParent = function(page) {
      return (page[1] === "work" || "blog") && $('#three').hasClass('active');
    };
    emptyContents = function(element) {
      $(element).delay(800).queue(function() {});
      return $(this).html("");
    };
    transitionToNormalPage = function() {
      $('#one').addClass('active');
      $('#bg-' + page[1]).addClass('active-effect');
      $('.site-header').css({
        top: '0px'
      });
      $('#home-nav').fadeOut(10);
      $('#top-nav').delay(1300).fadeIn(10);
      $('.bg').removeClass('active-effect');
      $("body").className = "";
      return $("body").addClass(page);
    };
    transitionToHomePage = function() {
      $('.site-header').css({
        top: '52px'
      });
      $('.page').removeClass('active');
      $('.bg').removeClass('active-effect');
      $('#home-nav').delay(900).fadeIn(10);
      $('#top-nav').fadeOut(10);
      $("body").className = "";
      return $("body").addClass("home");
    };
    pageLogic = function(data) {
      if (page) {
        if (isPost(page)) {
          $('#three').html($(data).find('#one').html());
          $('#three').addClass('active');
          return emptyContents('#one');
        } else if (isParent(page)) {
          $('#one').html($(data).find('#one').html());
          return $('#three').removeClass('active');
        } else {
          $('#three').removeClass('active');
          $('#two').html($(data).find('#one').html());
          if ($('#one').hasClass('active')) {
            $('#one').toggleClass('active');
            $('#two').toggleClass('active');
          } else {
            $('#two').addClass('active');
          }
          swapDivs('one', 'two');
          transitionToNormalPage();
          return emptyContents('#two');
        }
      } else {
        transitionToHomePage();
        emptyContents('one');
        return emptyContents('two');
      }
    };
    page = pageName();
    if (page) {
      if (isPost(page)) {
        $('#three').html($('#one').html());
        $('#three').addClass('active');
        emptyContents('#one');
      }
      transitionToNormalPage();
    }
    $("nav .about").hover(function() {
      $("#bg-about").toggleClass("hover-effect");
      return $("body").toggleClass("about");
    });
    $("nav .blog").hover(function() {
      $("#bg-blog").toggleClass("hover-effect");
      return $("body").toggleClass("blog");
    });
    $("nav .contact").hover(function() {
      $("#bg-contact").toggleClass("hover-effect");
      return $("body").toggleClass("contact");
    });
    $("nav .work").hover(function() {
      $("#bg-work").toggleClass("hover-effect");
      return $("body").toggleClass("work");
    });
    siteUrl = 'http://' + (document.location.hostname || document.location.host);
    $(document).delegate('a[href^="/"],a[href^="' + siteUrl + '"]', 'click', function(e) {
      e.preventDefault();
      return History.pushState({}, '', this.pathname);
    });
    return History.Adapter.bind(window, 'statechange', function() {
      var state;
      state = History.getState();
      return $.get(state.url, function(data) {
        document.title = $(data).find('title').text();
        page = pageName();
        return pageLogic(data);
      });
    });
  });

}).call(this);
