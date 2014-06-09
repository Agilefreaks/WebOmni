var webOmniApp = {
  config: {
    $win: $(window),
    $doc: $(document),
    deviceCount: 2,
    $fullBlock: $('.full-block'),
    $menuTrigger: $('.menu-trigger'),
    $deviceList: $('#device-list'),
    $htmlBody: $('html, body'),
    $goTo: $('.go-to'),
    $lightPanel: $(".light-bg"),
    $navBar: $('#header-bar'),
    $fullPage: $('#fullpage'),
    $deviceContinue: $('#device-continue')
  },

  appendHome: function () {
    window.location.hash = '#home';
  },

  runAnimation: function (i, timeline) {
    setTimeout(function () {
      $('.anim-list li').eq(i).addClass('active').siblings().removeClass('active');
    }, timeline);
  },

  callbacks: {
    toggleMenu: function () {
      var $this = $(this);

      $this.toggleClass('active');
    },

    toggleDevice: function () {
      var $this = $(this),
        $parent = $this.closest('#device-list');


      if ($parent.find('input:checked').length == webOmniApp.config.deviceCount) {
        $parent
          .find(':not(input:checked)').prop('disabled', true).end()
          .closest('form').find('#device-continue').prop('disabled', false);
        //disable tooltip
        $('#device-disabled-wrap').tooltip('destroy');
      } else {
        $parent
          .find('input:disabled').prop('disabled', false).end()
          .closest('form').find('#device-continue').prop('disabled', true);
        //enable tooltip
        $('#device-disabled-wrap').tooltip();
      }

    },

    goTo: function (e) {
      e.preventDefault();

      $.fn.fullpage.moveSectionDown();
    },
    animationTimeline: function () {
      var timeline = 0,
        $animList = $('.anim-list li');

        for (var i = 0; i < $animList.length; i++) {
          timeline = parseInt($animList.eq(i).data('time'), 10) + parseInt(timeline, 10);
          webOmniApp.runAnimation(i, timeline);
        }
    },

    startAnimation: function() {
      setTimeout(function() {
        comp.play();
        webOmniApp.callbacks.animationTimeline();
      }, 500);
    }
  },

  attachHandles: function () {
    this.config.$win.resize(webOmniApp.callbacks.resize);
    this.config.$menuTrigger.on('click', webOmniApp.callbacks.toggleMenu);
    this.config.$deviceList.on('change', 'input', webOmniApp.callbacks.toggleDevice);
    this.config.$goTo.on('click', webOmniApp.callbacks.goTo);
    this.config.$deviceContinue.on('click', webOmniApp.callbacks.startAnimation);
  },

  appPlugins: {
    initFullPage: function () {
      var $container = webOmniApp.config.$fullPage;

      if ($container.length) {
        $container.fullpage({
          verticalCentered: true,
          scrollOverflow: true,
          navigation: true,
          anchors: ['home', 'seemore', 'feedback', 'team'],
          resize: false,
          easing: 'easeInQuart',
          onLeave: function (index, nextIndex) {
            if ($('.section').eq(nextIndex - 1).hasClass('light-bg')) {
              $('#header-bar').addClass('styled');
            } else {
              $('#header-bar').removeClass('styled');
            }

            if (nextIndex == "2") {
              setTimeout(function () {
                $('#device-list').addClass('animated fadeInUpBig');
              }, 500);
            } else {
              $('#device-list').removeClass('animated fadeInUpBig');
            }
          },

          onSlideLeave: function (anchorLink, index, slideIndex, direction) {
            
            if (slideIndex >= 0) {
              $('#header-bar').removeClass('styled');
            } else {
              $('#header-bar').addClass('styled');
            }
          }
        });
      }
    },

    initBootstrapTooltip: function () {
      $('[data-toggle=tooltip]').tooltip();
    },

    init: function () {
      this.initBootstrapTooltip();
      this.initFullPage();
    }
  },

  init: function () {
    this.appendHome();
    this.appPlugins.init();
    this.attachHandles();
  }
};

  var comp;
  AdobeEdge.bootstrapCallback(function(compId) {
    comp = AdobeEdge.getComposition('EDGE-88305247').getStage();
  });

$(function () {
  webOmniApp.init();  
});


$(window).load(function () {

});
