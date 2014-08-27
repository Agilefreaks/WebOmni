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

// Global
var $viewport = $('html body'),
//  Scroll vars
  lastScrollTop = 0,
  poolingDelay = 250,
  $menuContent = $('.js-header-nav-content'),
  menuDetachedClass = 'header--detached',
  menuVisibleClass = 'header--visible',
  menuHiddenClass = 'header--hidden',
  $heroContent = $('.js-hero'),
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
  videoBodyClass = 'omni-video--action',
  videoTimeout = 1000,
// Contact form vars
  $contactForm = $('.js-contact-form'),
  $contactFormNotice = $('.js-contact-notice'),
  $contactFormFields = $('.js-contact-form input, .js-contact-form textarea'),
  $contactFormContainer = $('.js-contact-form-content');

var omnipaste = {

  init: function() {

    // Open in new window links with rel=external code
    omnipaste.externalLink();

    // Prevent default action on # (hash) links
    omnipaste.preventLink();

    // Menu hide / show on scroll
    omnipaste.scroll();

    // Scroll to section
    omnipaste.scrollToSection();

    // Toggle dropdown
    omnipaste.sectionToggle();

    // Mobile menu
    omnipaste.mobileMenuToggle();

    // Video player
    omnipaste.video();

    // Contact form
    omnipaste.contact();

    // Stop auto scroll on manual scroll
    $viewport.on("scroll mousedown DOMMouseScroll mousewheel keyup", function(e){
      if ( e.which > 0 || e.type === "mousedown" || e.type === "mousewheel"){
        $viewport.stop();
      }
    });
  },

  externalLink: function() { $('a[rel="external"]').attr('target','_blank'); },

  preventLink: function() { $('a[href="#"]').on('click', function(e) { e.preventDefault(); }); },

  scroll: function() {

    // Check for scroll function
    $(window).scroll(function() {
      scrollEvent = true;
    });

    // Do scroll polling at 250ms intervals
    setInterval (function() {
      if (scrollEvent) {
        hasScrolled();
        scrollEvent = false;
      }
    }, poolingDelay);

    // If scrolled do things
    function hasScrolled() {
      var navbarHeight = $menuContent.outerHeight(),
        currentPosition = $(this).scrollTop(),
        navbarOffset = $heroContent.offset().top;
      navbarPosition =  navbarOffset + navbarHeight;

      // Make sure the scroll is more than delta
      if (Math.abs(lastScrollTop - currentPosition) <= scrollDelta) { return; }

      if ( currentPosition > navbarPosition) {
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
  scrollToTop: function ( scrollDelay ) {
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

    $viewport.animate({ scrollTop: targetOffset }, scrollDelay);

  },
  // Scroll to section
  scrollToSection: function () {

    $sectionAction.on('click', function(e) {
      var sectionID = $(this).attr('data-id');

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
      var $dropdownID = $('#' + $(this).attr('data-id'));

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
      var videoAction	= $(this).attr("data-action");

      // Make sure dropdown is closed
      $dropdown.removeClass(dropdownActiveClass);
      $bodyTrigger.removeClass(dropdownClass);

      // Overlay video
      $videoContainer.toggleClass(videoActiveClass);
      $bodyTrigger.toggleClass(videoBodyClass);

      if (videoAction == 'play') {
        $videoPlayerObject.play();
        _gaq.push('_trackEvent', 'Presentation', 'video play');
      } else {
        $videoPlayerObject.pause();
        $videoPlayerObject.currentTime = 0;
        $videoPlayerObject.load();
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

    // Close video on end
    $videoPlayer.on('ended', function() {

      timer = setTimeout( function() {

        $videoPlayerObject.currentTime = 0;
        $videoPlayerObject.load();
        $videoContainer.toggleClass(videoActiveClass);
        $bodyTrigger.toggleClass(videoBodyClass);

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

  // Contact form
  contact: function() {
    // Validate Contact Form
    $contactForm.h5Validate();

    // Process Contact Form
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

        timer1 = setTimeout(function() {
          $contactFormNotice.fadeIn(1000);
          $contactFormFields.val('');
        },1000);

        // Fade out & reset form
        timer2 = setTimeout(function() {
          $contactFormNotice.fadeOut(800);
        },4500);

        // Fade in form
        timer3 = setTimeout( function() {
          $contactFormContainer.fadeIn(1000);
        },5500);
      }
      // Prevent actual form submit
      e.preventDefault();
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

jQuery(window).load(function($) {


// !---- End Document Load Function ----
});