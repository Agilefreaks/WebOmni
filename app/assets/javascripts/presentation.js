// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery.2.1.1
//= require twitter/bootstrap
//= require jquery_ujs
//= require jquery.easing.1.3
//= require jquery.cookie
//= require jquery.placeholder
//= require jquery.h5validate
//= require humane-rails

// !IE10 Viewport Fix
// --------------------------------------------------------------
if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
  var msViewportStyle = document.createElement('style');
  msViewportStyle.appendChild(document.createTextNode('@-ms-viewport{ width:auto !important }'));
  document.getElementsByTagName('head')[0].appendChild(msViewportStyle);
}

// !Document ready (loaded)
// --------------------------------------------------------------
jQuery(document).ready(function($) {

  // Detect Safari / Chrome
  /*
   function isChrome() {
   if (/Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor) ) { return true; }
   return false;
   }
   function isSafari() {
   if (/Safari/.test(navigator.userAgent) && /Apple Computer/.test(navigator.vendor) ) { return true; }
   return false;
   }
   if (isSafari()) { $('html').addClass(' safari'); }
   if (isChrome()) { $('html').addClass(' chrome'); }
   */

  // Open in new window links with rel=external code
  $('a[rel="external"]').attr('target','_blank');

  // Prevent default action on # (hash) links
  $('a[href="#"]').click( function(e) { e.preventDefault(); });

  // Initialize scroll vars
  var didScroll;
  var lastScrollTop	= 0;
  var poolingDelay	= 250;

  // Check for scroll function
  $(window).scroll(function(e) { didScroll = true; });

  // Do scroll polling at 250ms intervals
  setInterval (function() {
    if (didScroll) {
      hasScrolled();
      didScroll = false;
    }
  }, poolingDelay);

  // If we have scroll detected do stuff
  function hasScrolled() {
    var menuContent		= $('.js-header-nav-content');
    var menuDetached	= 'header--detached';
    var menuVisible		= 'header--visible';
    var menuHidden		= 'header--hidden';
    var navbarHeight	= menuContent.outerHeight();
    var currentPosition	= $(this).scrollTop();
    var delta			= 5;
    var detachDelay		= 200;

    // Make sure the scroll is more than delta
    if (Math.abs(lastScrollTop - currentPosition) <= delta) { return; }

    if ( currentPosition > navbarHeight ) {
      // Needs to fire after menuHidden to prevent hide animation
      setTimeout(function() {
        // Detach menu
        menuContent.addClass(menuDetached);
      }, detachDelay);
    } else {
      // Attach menu
      menuContent.removeClass(menuDetached);
    }
    // Hide on scroll down
    if (currentPosition > lastScrollTop && currentPosition > navbarHeight) {
      // Scroll down
      menuContent.removeClass(menuVisible).addClass(menuHidden);

    } else {
      // Scroll Up
      if (currentPosition + $(window).height() < $(document).height()) {
        menuContent.removeClass(menuHidden).addClass(menuVisible);
      }
    }
    lastScrollTop = currentPosition;
  }

  // Scroll to top function
  function scrollToTop (speed) { $('html, body').animate({ scrollTop: 0 }, speed); }

  // Scroll to ID function
  function scrollToID (id, speed){
    var scrollOffset	= 0;
    var targetOffset	= $('#' + id).offset().top - scrollOffset;

    $('html,body').animate({ scrollTop: targetOffset }, speed);
  }

  // Scroll to section
  $('.js-goto-section').on('click', function(e) {
    var sectionID	= $(this).attr('data-id');
    var scrollDelay	= 750;

    // Scroll
    scrollToID(sectionID, scrollDelay);
    //Prevent default action
    e.preventDefault();
  });

  // Section Toggle
  $('.js-toggle-dropdown').on('click', function (e) {
    var bodyTrigger		= $('.js-body-action');
    var bodyClass		= 'dropdown--action';
    var dropdownActive	= 'dropdown--open';
    var dropdownID		= $('#' + $(this).attr('data-id'));
    var scrollDelay		= 750;

    dropdownID.toggleClass(dropdownActive);
    bodyTrigger.toggleClass(bodyClass);

    // Scroll to top
    scrollToTop(scrollDelay);
    // Prevent default action
    e.preventDefault();
  });

  //Video Play
  $('.js-omni-video').on('click', function (e) {
    var bodyTrigger		= $('.js-body-action');
    var bodyClass		= 'omni-video--action';
    var dropdownClass	= 'dropdown--action';
    var globalDropdown	= $('.dropdown');
    var dropdownActive	= 'dropdown--open';
    var video			= $('.js-omni-video-player').get(0);
    var videoActive		= 'omni-video--active';
    var videoID			= $('#' + $(this).attr('data-id'));
    var videoAction		= $(this).attr("data-action");
    var scrollDelay		= 750;

    globalDropdown.removeClass(dropdownActive);
    bodyTrigger.removeClass(dropdownClass);

    videoID.toggleClass(videoActive);
    bodyTrigger.toggleClass(bodyClass);

    if (videoAction == 'play') {
      video.play();
    } else {
      video.pause();
      video.currentTime = 0;
      video.load();
    }
    // Scroll to top
    scrollToTop(scrollDelay);
    // Prevent default action
    e.preventDefault();
  });

  // Video play / pause toggle
  var $omni_video_player = $('.js-omni-video-player');
  $omni_video_player.on('click', function () {
    var video = $('.js-omni-video-player').get(0);

    if (video.paused === false) {
      video.pause();
    } else {
      video.play();
    }
  });

  // Close video on end
  $omni_video_player.on('ended', function() {
    var video			= $('.js-omni-video-player').get(0);
    var videoContainer	= $('#omni-video');
    var videoActive		= 'omni-video--active';
    var bodyTrigger		= $('.js-body-action');
    var bodyClass		= 'omni-video--action';
    var videoTimeout	= 1000;

    timer = setTimeout( function() {

      video.currentTime = 0;
      video.load();
      videoContainer.toggleClass(videoActive);
      bodyTrigger.toggleClass(bodyClass);

    }, videoTimeout);
  });

  // Full screen on double click
  $omni_video_player.on('dblclick', function() {
    var video = $('.js-omni-video-player').get(0);

    if (video.requestFullscreen) {
      video.requestFullscreen();

    } else if (video.mozRequestFullScreen) {
      video.mozRequestFullScreen(); // Firefox

    } else if (video.webkitRequestFullscreen) {
      video.webkitRequestFullscreen(); // Chrome and Safari
    }
  });

  // Update the slider with the video progress
  $omni_video_player.on('timeupdate', function() {
    var seekBar	= $('.js-omni-video-seek').get(0);
    var video	= $('.js-omni-video-player').get(0);
    var value;

    // Calculate the slider value
    value = (100 / video.duration) * video.currentTime;
    // Update the slider value
    seekBar.value = value;
  });

  // Hook the slider with the video
  var $js_omni_video_seek = $('.js-omni-video-seek');
  $js_omni_video_seek.on('change', function() {
    var seekBar	= $('.js-omni-video-seek').get(0);
    var video	= $('.js-omni-video-player').get(0);

    // Calculate the new time
    video.currentTime = video.duration * (seekBar.value / 100);
  });

  // Pause the video when the slider handle is being dragged
  $js_omni_video_seek.on("mousedown", function() {
    var video = $('.js-omni-video-player').get(0);

    video.pause();
  });
  // Play the video when the slider handle is dropped
  $js_omni_video_seek.on("mouseup", function() {
    var video = $('.js-omni-video-player').get(0);

    video.play();
  });

  // Validate Contact Form
  var $js_contact_form = $('.js-contact-form');
  $js_contact_form.h5Validate();

  // Process Contact Form
  $js_contact_form.submit(function(e) {
    var result		= $('.js-contact-form').h5Validate('allValid');
    var notice		= $('.js-contact-notice');
    var fields		= $('.js-contact-form input, .js-contact-form textarea');
    var container	= $('.js-contact-form-content');
    var data;
    var url;

    if ( result === true ) {
      // Serialize contact data
      data = $(this).serialize();
      // Get URL from action
      url = $(this).attr('action');

      // Send request
      $.ajax({
        url: url,
        data: data,
        type: 'post'
      });

      // Fade out & display message
      container.fadeOut(800);
      var timer1 = setTimeout(function() {
        notice.fadeIn(1000);
        fields.val('');
      },1000);

      // Fade out & reset form
      var timer2 = setTimeout(function() {
        notice.fadeOut(800);
      },4500);

      // Fade in form
      var timer3 = setTimeout( function() {
        container.fadeIn(1000);
      },5500);
    }
    // Prevent actual form submit
    e.preventDefault();
  });


// !---- End Document Ready Function ----
});


// !Document load (in process of loading) function
// --------------------------------------------------------------

jQuery(window).load(function($) {

// !---- End Document Load Function ----
});