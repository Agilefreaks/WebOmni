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
  var msViewportStyle = document.createElement("style");
  msViewportStyle.appendChild(
    document.createTextNode(
      "@-ms-viewport{width:auto!important}"
    )
  );
  document.getElementsByTagName("head")[0].appendChild(msViewportStyle);
}

jQuery(document).ready(function ($) {
  // Open in new window links with rel=external code
  $('a[rel="external"]').attr("target", "_blank");

  // Prevent default on # links
  $('a[href="#"]').click(function (e) {
    e.preventDefault();
  });

  // Delay scroll input method
  $.fn.scrolled = function (waitTime, fn) {
    var tag = "scrollTimer";
    this.scroll(function () {
      var self = $(this);
      var timer = self.data(tag);
      if (timer) {
        clearTimeout(timer);
      }
      timer = setTimeout(function () {
        self.data(tag, null);
        fn();
      }, waitTime);
      self.data(tag, timer);
    });
  };

  // Menu Logic
  //Init var for scroll direction
  var lastScrollTop = 0;
  $(window).scrolled(10, function () {
    var menuTrigger = $('.js-body-action');
    var menuContent = menuTrigger;
    var menuActive = 'header--floating';
    var menuOffset = 10;
    var win = $(window);
    var scrollDirection = win.scrollTop();

    // Complex Menu Logic (Show on scrollUp)
    // Check for scroll position
    if (win.scrollTop() > menuTrigger.offset().top + menuTrigger.outerHeight(true)) {
      // If scroll beyond main visible area stick menu to scroll
      menuContent.addClass(menuActive);
    } else {
      // If scroll in main visible area move menu to top
      menuContent.removeClass(menuActive);

      if (win.scrollTop() < menuTrigger.offset().top + menuTrigger.outerHeight(true)) {
        // If menu bar still visible
        menuContent.removeClass(menuActive);

      } else {
        menuContent.addClass(menuActive);
      }
    }
    //Check for scroll direction - Hide on scroll down
    if (scrollDirection > lastScrollTop && win.scrollTop() > menuTrigger.offset().top + menuTrigger.outerHeight(true)) {
      // Down scroll
      menuTrigger.removeClass(menuActive);

    } else if (scrollDirection < lastScrollTop && win.scrollTop() > menuOffset) {
      // Up scroll
      menuTrigger.addClass(menuActive);
    }

    lastScrollTop = scrollDirection;
  });

  // Scroll To ID Function
  function scrollToID(id, speed) {
    var offSet = 0;
    var targetOffset = $(id).offset().top - offSet;

    $("html,body").animate({scrollTop: targetOffset}, speed);
  }

  function scrollToTop(speed) {
    $('html, body').animate({scrollTop: 0}, speed);
  }

  // Scroll To ID
  $('.js-goto-section').on('click', function (e) {
    e.preventDefault();
    var sectionID = $(this).attr("data-id");
    scrollToID('#' + sectionID, 750);
  });

  // Section Toggle
  $('.js-toggle-dropdown').on('click', function (e) {
    var bodyTrigger = $('.js-body-action');
    var bodyClass = "dropdown--action";
    var dropdownActive = "dropdown--open";
    var dropdownID = $(this).attr("data-id");

    $('#' + dropdownID).toggleClass(dropdownActive);
    $(bodyTrigger).toggleClass(bodyClass);

    scrollToTop(750);

    e.preventDefault();
  });

  //Video Play
  $('.js-omni-video').on('click', function (e) {
    var bodyTrigger = $('.js-body-action');
    var bodyClass = "omni-video--action";

    var dropdownClass = "dropdown--action";
    var globalDropdown = $('.dropdown');
    var dropdownActive = "dropdown--open";

    var videoActive = "omni-video--active";
    var videoID = $(this).attr("data-id");
    var videoAction = $(this).attr("data-action");

    var videoPlayer = $('.js-omni-video-player').get(0);

    $(globalDropdown).removeClass(dropdownActive);
    $(bodyTrigger).removeClass(dropdownClass);

    $('#' + videoID).toggleClass(videoActive);
    $(bodyTrigger).toggleClass(bodyClass);

    if (videoAction == 'play') {
      videoPlayer.play();
    } else {
      videoPlayer.pause();
      videoPlayer.currentTime = 0;
      videoPlayer.load();
    }

    scrollToTop(750);

    e.preventDefault();
  });

  // Video PLay / Pause Toggle
  var $js_omni_video_player = $('.js-omni-video-player');
  $js_omni_video_player.on('click', function (e) {
    video = $('.js-omni-video-player').get(0);

    if (video.paused === false) {
      video.pause();
    } else {
      video.play();
    }
  });

  // Full screen on double click
  $js_omni_video_player.on('dblclick', function () {
    video = $('.js-omni-video-player').get(0);

    if (video.requestFullscreen) {
      video.requestFullscreen();
    } else if (video.mozRequestFullScreen) {
      video.mozRequestFullScreen(); // Firefox
    } else if (video.webkitRequestFullscreen) {
      video.webkitRequestFullscreen(); // Chrome and Safari
    }
  });

  // Hook the slider with the video
  var $js_omni_video_seek = $('.js-omni-video-seek');
  $js_omni_video_seek.on('change', function () {
    seekBar = $('.js-omni-video-seek').get(0);
    video = $('.js-omni-video-player').get(0);

    // Calculate the new time
    var time = video.duration * (seekBar.value / 100);

    // Update the video time
    video.currentTime = time;
  });
  // Update the slider with the video progress
  $js_omni_video_player.on('timeupdate', function () {
    seekBar = $('.js-omni-video-seek').get(0);
    video = $('.js-omni-video-player').get(0);

    // Calculate the slider value
    var value = (100 / video.duration) * video.currentTime;

    // Update the slider value
    seekBar.value = value;
  });

  // Pause the video when the slider handle is being dragged
  $js_omni_video_seek.on("mousedown", function () {
    video = $('.js-omni-video-player').get(0);
    video.pause();
  });
  // Play the video when the slider handle is dropped
  $js_omni_video_seek.on("mouseup", function () {
    video = $('.js-omni-video-player').get(0);
    video.play();
  });

  //Validate Contact Form
  var $js_contact_form = $('.js-contact-form');
  $js_contact_form.h5Validate();
  $js_contact_form.submit(function (event) {

    var result = $('.js-contact-form').h5Validate('allValid');
    if (result === true) {
      // Serialize contact data
      data = $(this).serialize();
      // Send request
      url = $(this).attr('action');

      $.ajax({
        url: url,
        data: data,
        type: 'post',
        success: function (msg) {

          // Place error message in notice
          //$('.js-contact-notice').html(msg);

          // Push Google Analytics event
          //_gaq.push(['_trackEvent', 'Contact', 'Contact request', 'Contact sent!']);
        }
      });

      // Fade out & display message
      $('.js-contact-form-content').fadeOut(800);

      timer1 = setTimeout(function () {
        $('.js-contact-notice').fadeIn(1000);
        $('.js-contact-form input, .js-contact-form textarea').val('');
      }, 1000);

      // Fade out & reset form
      timer2 = setTimeout(function () {
        $('.js-contact-notice').fadeOut(800);
      }, 4500);

      // Fade in form
      timer3 = setTimeout(function () {
        $('.js-contact-form-content').fadeIn(1000);
      }, 5500);
    }

    //Return false so we don't actually submit the form
    return false;
  });


// !---- End Document Ready Function ----
});


// --------------------------------------------------------------

jQuery(window).load(function ($) {

// !---- End Window Load Function ----
});