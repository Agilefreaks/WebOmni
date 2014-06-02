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
    $fullPage: $('#fullpage')
  },

  appendHome: function () {
    window.location.hash = '#home';
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
    }
  },

  attachHandles: function () {
    this.config.$win.resize(webOmniApp.callbacks.resize);
    this.config.$menuTrigger.on('click', webOmniApp.callbacks.toggleMenu);
    this.config.$deviceList.on('change', 'input', webOmniApp.callbacks.toggleDevice);
    this.config.$goTo.on('click', webOmniApp.callbacks.goTo);
  },

  appPlugins: {
    initFullPage: function () {
      var $container = webOmniApp.config.$fullPage;

      if ($container.length) {
        $container.fullpage({
          verticalCentered: true,
          scrollOverflow: true,
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

$(function () {
  webOmniApp.init();
});


$(window).load(function () {

});
