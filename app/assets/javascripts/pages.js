// Global
var $viewport = $('html, body'),
  $window = $(window),
  windowHeight = $window.height(),
  windowHeightPadded = windowHeight / 1.2,
//  Scroll vars
  lastScrollTop = 0,
  poolingDelay = 250,
  $menuContent = $('.js-header-nav-content'),
  menuDetachedClass = 'header--detached',
  menuVisibleClass = 'header--visible',
  menuHiddenClass = 'header--hidden',
  $heroContent = $('.js-hero'),
  heroHeight = $heroContent.outerHeight(),
  scrollDelay = 750,
  scrollDelta	= 5,
  scrollEvent = false,
  detachDelay	= 200,
// Dropdown vars
  $bodyTrigger = $('.js-body-action'),
  $dropdown = $('.js-dropdown'),
  $dropdownAction = $('.js-toggle-dropdown'),
  dropdownClass = 'dropdown--action',
  dropdownActiveClass	= 'dropdown--open',
  dropdownBodyClass = 'dropdown--action',
// Toggle vars
  $sectionAction = $('.js-goto-section'),
// Mobile menu vars
  $mobileMenuToggle = $('.js-mobile-menu-toggle'),
  mobileMenuActiveClass = 'header--mobile',
// Video vars
  $videoPlayer = $('.js-omni-video-player'),
  $videoPlayerObject = $videoPlayer.get(0),
  $videoContainer = $('.js-omni-video'),
  $videoSeek = $('.js-omni-video-seek'),
  $videoSeekObject = $videoSeek.get(0),
  $videoToggle = $('.js-omni-video-toggle'),
  videoActiveClass = 'omni-video--active',
  videoOverlayClass = 'omni-video--overlay',
  videoBodyClass = 'omni-video--action',
  videoTimeout = 1000,
// AuthCode	vars
  authCode = false,
  $authCodeAction = $('.js-get-auth-code'),
  authCodeURL = '#',
  authCodeInvisibleClass = 'button--invisible',
// Contact form vars
  $contactForm = $('.js-contact-form'),
  $contactFormNotice = $('.js-contact-notice'),
  $contactFormFields = $('.js-contact-form input, .js-contact-form textarea'),
  $contactFormContainer = $('.js-contact-form-content'),
//	Animations cars
  animationTriggerClass = 'js-animation-trigger',
  animationDoneClass = 'animated';

var omnipaste = {

  init: function() {

    // Open in new window links with rel=external code
    omnipaste.externalLink();

    // Prevent default action on # (hash) links
    omnipaste.preventLink();

    // Watch for location hash - Do not call directly from here (window.load)
    // omnipaste.detectLocationHash();

    // Set location hash function - Do not call directly from here (helper function)
    //omnipaste.setLocationHash(id);

    // Set hash according to location - Do not call directly from here (omnipaste.scroll)
    //omnipaste.setLocationScroll();

    // Watch for scroll events
    omnipaste.scroll();

    // Scroll to top function - Do not call directly from here (helper function)
    //omnipaste.scrollToTop(scrollDelay);

    // Scroll to ID function - Do not call directly from here (helper function)
    //omnipaste.scrollToID(id);

    // Scroll to section
    omnipaste.scrollToSection();

    // Toggle dropdown
    omnipaste.sectionToggle();

    // Mobile menu
    omnipaste.mobileMenuToggle();

    // Video player
    omnipaste.video();

    // Close video function - Do not call directly from here (helper function)
    //omnipaste.videoClose();

    // Play video function - Do not call directly from here (helper function)
    //omnipaste.videoPlay();

    // Manage video visibility on scroll - Do not call directly from here (omnipaste.scroll)
    //omnipaste.videoVisibility();

    // Generate authcode
    omnipaste.authCode();

    // Contact form
    omnipaste.contact();

    // Manage animations on scroll - Do not call directly from here (omnipaste.scroll)
    //omnipaste.animations();

    // Stop all animations, fades, transitions on manual scroll
    omnipaste.stop();
  },

  // Open in new window links with rel=external code
  externalLink: function() { $('a[rel="external"]').attr('target','_blank'); },

  // Prevent default action on # (hash) links
  preventLink: function() { $('a[href="#"]').on('click', function(e) { e.preventDefault(); }); },

  // Watch for location hash
  detectLocationHash: function() {
    //Get current hash
    var hash = window.location.hash.substr(1);

    //Check if hash is empty
    if (hash !== '' && typeof hash !== 'undefined') {
      //Scroll to element
      omnipaste.scrollToTop(100);

      setTimeout( function () {
        omnipaste.scrollToID(hash);
      }, 300);

      if (hash === 'video' ) {
        omnipaste.videoPlay();
      }
    } else {
      omnipaste.scrollToTop();
    }
  },

  // Set location hash
  setLocationHash: function(id) {
    var hash;

    if (id === '') {
      // Check if the browser supports the pushState
      if (history.replaceState) {
        history.replaceState('', document.title, window.location.pathname);
      } else {
        window.location.hash = '';
      }
    } else {
      hash = '#' + id;

      $menuContent.find('a').removeClass('current');
      $menuContent.find('a[data-id="'+ id +'"]').addClass('current');

      // Check if the browser supports the pushState
      if (history.replaceState) {
        history.replaceState({},'', hash);

        // Else provide a fallback
      } else {
        var scrollPosition = document.body.scrollTop;
        window.location.hash = id;
        document.body.scrollTop = scrollPosition;
      }
    }
  },

  // Set hash according to location
  setLocationScroll: function() {
    $('.js-nav-hash').each(function() {
      if (
        $(this).offset().top < window.pageYOffset + 10 &&
        $(this).offset().top + $(this).height() > window.pageYOffset + 10) {

        omnipaste.setLocationHash($(this).attr('id'));
      }
    });
  },

  // Watch for scroll events
  scroll: function() {

    // Check for scroll function
    $(window).scroll(function() {
      scrollEvent = true;
    });

    // Do scroll polling at 250ms intervals
    setInterval (function() {
      if (scrollEvent) {
        // Manage menu visibility
        menuVisibilty();
        // Manage video visibility
        omnipaste.videoVisibility();
        // Manage animations
        omnipaste.animations();
        // Manage location hash
        omnipaste.setLocationScroll();
        // Reset scroll count
        scrollEvent = false;
      }
    }, poolingDelay);

    // If scrolled do things
    function menuVisibilty() {
      var navbarHeight = $menuContent.outerHeight(),
        currentPosition = $(this).scrollTop(),
        navbarOffset = $heroContent.offset().top,
        navbarPosition =  navbarOffset + navbarHeight;

      // Make sure the scroll is more than delta
      if (Math.abs(lastScrollTop - currentPosition) <= scrollDelta) { return; }

      if (currentPosition > navbarPosition) {
        // Needs to fire after menuHidden to prevent hide animation
        setTimeout(function() {
          // Detach menu
          $menuContent.addClass(menuDetachedClass);
        }, detachDelay);
      } else {
        // Attach menu
        $menuContent.removeClass(menuDetachedClass);
      }
      // Hide on scroll down
      if (currentPosition > lastScrollTop && currentPosition > navbarPosition) {
        // Scroll down
        $menuContent.removeClass(menuVisibleClass).addClass(menuHiddenClass);

      } else {
        // Scroll Up
        if (currentPosition + $(window).height() < $(document).height()) {
          $menuContent.removeClass(menuHiddenClass).addClass(menuVisibleClass);
        }
      }
      lastScrollTop = currentPosition;
    }
  },

  // Scroll to top function
  scrollToTop: function (scrollDelay) {
    // Set defaults
    scrollDelay = scrollDelay || this.scrollDelay;

    $menuContent.removeClass(mobileMenuActiveClass);

    $viewport.animate({ scrollTop: 0 }, scrollDelay);
  },

  // Scroll to ID function
  scrollToID: function (id, scrollDelay, scrollOffset) {
    // Set defaults
    scrollDelay = scrollDelay || 750;
    scrollOffset = scrollOffset || 0;

    var targetOffset = $('#' + id).offset().top - scrollOffset;

    $menuContent.removeClass(mobileMenuActiveClass);

    $viewport.stop().animate({ scrollTop: targetOffset }, scrollDelay).delay('1500', function() {
      // Set location Hash
      omnipaste.setLocationHash(id);
    });
  },

  // Scroll to section
  scrollToSection: function () {

    $sectionAction.on('click', function(e) {
      var sectionID = $(this).data('id');

      // Scroll
      omnipaste.scrollToID(sectionID);
      //Prevent default action
      e.preventDefault();
    });
  },

  // Toggle section
  sectionToggle: function () {
    // Section Toggle
    $dropdownAction.on('click', function (e) {
      var $dropdownID = $('#' + $(this).data('id'));

      $dropdownID.toggleClass(dropdownActiveClass);
      $bodyTrigger.toggleClass(dropdownBodyClass);
      $menuContent.removeClass(mobileMenuActiveClass);

      // Scroll to top
      omnipaste.scrollToTop();
      // Prevent default action
      e.preventDefault();
    });
  },

  // Toggle mobile menu
  mobileMenuToggle: function() {
    $mobileMenuToggle.on('click', function (e) {
      $menuContent.toggleClass(mobileMenuActiveClass);
      // Prevent default action
      e.preventDefault();
    });
  },

  // Video functions
  video: function () {
    // Video Play
    $videoToggle.on('click', function (e) {
      var videoAction	= $(this).data("action");

      // Make sure dropdown is closed
      $dropdown.removeClass(dropdownActiveClass);
      $bodyTrigger.removeClass(dropdownClass);

      if ( videoAction == 'play') {
        // Play
        omnipaste.videoPlay();
      } else {
        // Wait a bit
        setTimeout( function() {
          // Close
          omnipaste.videoClose();
        }, 200);
      }

      // Scroll to top
      omnipaste.scrollToTop();
      // Prevent default action
      e.preventDefault();
    });

    // Video play / pause toggle
    $videoPlayer.on('click', function () {
      if ($videoPlayerObject.paused === false) {
        $videoPlayerObject.pause();
      } else {
        $videoPlayerObject.play();
      }
    });

    // Close video on ESC
    $(document).on('keydown', function (e) {
      if (e.keyCode === 27) { // ESC
        omnipaste.videoClose();
      }
    });

    // Close video on end
    $videoPlayer.on('ended', function() {
      // Wait a bit before closing
      setTimeout( function() {
        // Close
        omnipaste.videoClose();
      }, videoTimeout);
    });

    // Full screen on double click
    $videoPlayer.on('dblclick', function() {
      if ($videoPlayerObject.requestFullscreen) {
        $videoPlayerObject.requestFullscreen();

      } else if ($videoPlayerObject.mozRequestFullScreen) {
        $videoPlayerObject.mozRequestFullScreen(); // Firefox

      } else if ($videoPlayerObject.webkitRequestFullscreen) {
        $videoPlayerObject.webkitRequestFullscreen(); // Chrome and Safari
      }
    });

    // Hook the slider with the video
    $videoSeek.on('change', function() {
      // Update the video time
      $videoPlayerObject.currentTime = $videoPlayerObject.duration * ($videoSeekObject.value / 100);
    });

    // Update the slider with the video progress
    $videoPlayer.on('timeupdate', function() {
      var value;

      // Calculate the slider value
      value = (100 / $videoPlayerObject.duration) * $videoPlayerObject.currentTime;
      // Update the slider value
      $videoSeekObject.value = value;
    });

    // Pause the video when the slider handle is being dragged
    $videoSeek.on("mousedown", function() { $videoPlayerObject.pause(); });

    // Play the video when the slider handle is dropped
    $videoSeek.on("mouseup", function() { $videoPlayerObject.play(); });
  },

  // Play video function
  videoPlay: function () {
    // Show video container
    $bodyTrigger.addClass(videoBodyClass);

    setTimeout( function() {
      // Show video
      $videoContainer.addClass(videoActiveClass);

      setTimeout(function() {
        // Show video overlay
        $bodyTrigger.addClass(videoOverlayClass);
      }, 200);

      setTimeout(function() {
        // Play video
        $videoPlayerObject.play();
      }, 800);

    }, 200);

    omnipaste.setLocationHash('video');
  },

  // Close video function
  videoClose: function () {
    // Hide video content
    $videoContainer.removeClass(videoActiveClass);
    // Hide video
    $bodyTrigger.removeClass(videoBodyClass);

    setTimeout(function() {
      // Reset video
      $videoPlayerObject.pause();
      $videoPlayerObject.load();

      // Hide video overlay
      $bodyTrigger.removeClass(videoOverlayClass);
    }, 200);

    omnipaste.setLocationHash('');
  },

  // Manage Video Visibility on Scroll
  videoVisibility: function() {

    if (window.pageYOffset > heroHeight) { omnipaste.videoClose(); }
  },

  // Get Auth Code
  authCode: function() {

    $authCodeAction.on('click', function () {
      var token = $(this).data('token');

      if (authCode === false) {
        $.ajax({
          url: authCodeURL,
          data: token,
          type: 'get',
          success: function(msg) {
            msg = "Gbqw0Vpr86RZ"; // Dev: Fixed message for display purposes - REMOVE THIS LINE!!!
            $authCodeAction.addClass(authCodeInvisibleClass);
            setTimeout( function() {
              $authCodeAction.html(msg);
              $authCodeAction.removeClass(authCodeInvisibleClass);
            },1000);
          }
        });
        authCode = true;
      }
    });
  },

  // Contact form
  contact: function() {
    // Validate contact form
    $contactForm.h5Validate();

    // Process contact form
    $contactForm.submit(function(e) {
      var result = $contactForm.h5Validate('allValid'),
        data,
        url;

      if ( result === true ) {
        // Serialize contact data
        data = $(this).serialize();
        // Get URL from action
        url = $(this).attr('action');

        // Send request
        $.ajax({
          url: url,
          data: data,
          type: 'post',
          success: function(msg) {

            // Place error message in notice
            //$contactFormNotice.html(msg);

            // Push Google Analytics event
            //_gaq.push(['_trackEvent', 'Contact', 'Contact request', 'Contact sent!']);
          }
        });

        // Fade out & display message
        $contactFormContainer.fadeOut(800);

        setTimeout(function() {
          $contactFormNotice.fadeIn(1000);
          $contactFormFields.val('');
        },1000);

        // Fade out & reset form
        setTimeout(function() {
          $contactFormNotice.fadeOut(800);
        },4500);

        // Fade in form
        setTimeout(function() {
          $contactFormContainer.fadeIn(1000);
        },5500);
      }
      // Prevent actual form submit
      e.preventDefault();
    });
  },

  // Animations
  animations: function() {
    var hasScrolled = $window.scrollTop(),
      $notAnimated = $('.' + animationTriggerClass + ":not('."+ animationDoneClass +"')"),
      $animated = $('.' + animationTriggerClass + "."+ animationDoneClass);

    // If items not animated
    $notAnimated.each(function () {
      var $this = $(this),
        animationOffset = $this.offset().top,
        animationTimeout = parseInt($this.data('timeout'),10),
        animationName = $this.data('animation');

      if (hasScrolled + windowHeightPadded > animationOffset) {
        if (animationTimeout) {
          setTimeout(function(){
            $this.addClass(animationDoneClass + ' ' + animationName);
          }, animationTimeout);
        } else {
          $this.addClass(animationDoneClass + ' ' + animationName);
        }
      } else {
        $this.removeClass(animationDoneClass);
        $this.removeClass(animationName);
      }
    });

    // If items are animated and scrolled out of view
    $animated.each(function () {
      var $this = $(this),
        animationOffset = $this.offset().top,
        animationName = $this.data('animation');

      if (hasScrolled + windowHeightPadded < animationOffset || hasScrolled + windowHeightPadded > animationOffset + windowHeight) {
        $this.removeClass(animationDoneClass);
        $this.removeClass(animationName);
      }
    });
  },

  // Stop all animations, fades, transitions on manual scroll
  stop: function() {
    $viewport.on("scroll mousedown DOMMouseScroll mousewheel keyup", function(e){
      if ( e.which > 0 || e.type === "mousedown" || e.type === "mousewheel"){
        $viewport.stop();
      }
    });
  }
};

// !Document ready (loaded)
// --------------------------------------------------------------
jQuery(document).ready(function() {

  // Init scripts
  omnipaste.init();

// !---- End Document Ready Function ----
});

// !Document load (in process of loading) function
// --------------------------------------------------------------

jQuery(window).load(function() {

  // Init watch for location hash
  omnipaste.detectLocationHash();

// !---- End Document Load Function ----
});
