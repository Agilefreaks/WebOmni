var comp, comp2, comp3;

var webOmniApp = {
  config: {
    $win: $(window),
    $doc: $(document),
    deviceCount: 2,
    $fullBlock: $('.full-block'),
    $menuTrigger: $('.menu-trigger'),
    $menuOverlay: $('.menu-overlay'),
    $deviceList: $('#device-list'),
    $htmlBody: $('html, body'),
    $goTo: $('.go-to'),
    $lightPanel: $(".light-bg"),
    $navBar: $('#header-bar'),
    $fullPage: $('#fullpage'),
    $deviceContinue: $('#device-continue'),
    $btnReplay: $('.btn-replay')
  },

  mobileCheck: function () {
    var check = false;
    (function (a) {
      if (/(android|ipad|playbook|silk|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(a.substr(0, 4)))check = true
    })(navigator.userAgent || navigator.vendor || window.opera);
    return check;
  },

  appendHome: function () {
    if (!window.location.hash) {
      window.location.hash = '#home';
    }
  },

  callbacks: {
    toggleMenu: function () {
      var $this = $(this);

      if ($this.hasClass('active')) {
        webOmniApp.callbacks.closeMenu();
      } else {
        webOmniApp.callbacks.openMenu();
      }

    },

    openMenu: function () {
      webOmniApp.config.$menuTrigger.addClass('active');
      webOmniApp.config.$menuOverlay.addClass('open');
    },

    closeMenu: function (e) {
      var $this = $(this);

      if ($(window).width() < 600) {
        e.preventDefault();
        var blockId = $this.data('id');

        webOmniApp.callbacks.goToBlock(blockId);
      }

      webOmniApp.config.$menuTrigger.removeClass('active');
      webOmniApp.config.$menuOverlay.removeClass('open');
    },

    goToBlock: function (id) {

      console.log($(id).offset().top);

      $('html, body').animate({
        scrollTop: $(id).offset().top
    }, 1000);
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

startAnimation: function (compAnim) {
  switch (compAnim) {
    case "comp":
      comp.play("start");
      break;
    case "comp2":
      comp2.play("start");
      break;
    case "comp3":
      comp3.play("start");
      break;
  }
}
,

goToDevice: function () {
  var $checked = [];
  $('#device-list').find('input:checked').each(function () {
    $checked.push($(this).prop('name'));
  });

  $.fn.fullpage.moveTo(2, $checked[0] + "-" + $checked[1]);
}
,

replayAnimation: function (e) {
  var $this = $(this),
      compAnim = $this.data('composition');

  webOmniApp.callbacks.startAnimation(compAnim);
  e.preventDefault();
}
,

restartAnimation: function () {
  comp.stop(0);
  comp2.stop(0);
  comp3.stop(0);
}
},

attachHandles: function () {
  this.config.$win.resize(webOmniApp.callbacks.resize);
  this.config.$menuTrigger.on('click', webOmniApp.callbacks.toggleMenu);
  this.config.$menuOverlay.on('click', 'a', webOmniApp.callbacks.closeMenu);
  this.config.$deviceList.on('change', 'input', webOmniApp.callbacks.toggleDevice);
  this.config.$goTo.on('click', webOmniApp.callbacks.goTo);
  this.config.$deviceContinue.on('click', webOmniApp.callbacks.goToDevice);
  this.config.$btnReplay.on('click', webOmniApp.callbacks.replayAnimation);
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
        css3: true,
        easing: 'easeInQuart',
        onLeave: function (index, nextIndex) {
          if ($('.section').eq(nextIndex - 1).hasClass('light-bg')) {
            $('#header-bar').addClass('styled');
          } else {
            $('#header-bar').removeClass('styled');
          }

          if (nextIndex == "2") {

            window.location.hash = '#seemore';

            $('.controlArrow').hide();

            setTimeout(function () {
              $('#device-list').addClass('animated fadeInUpBig');
            }, 500);
          } else {
            $('#device-list').removeClass('animated fadeInUpBig');
          }
        },

        afterSlideLoad: function (anchorLink, index, slideAnchor, slideIndex) {
          webOmniApp.callbacks.restartAnimation();

          switch (slideAnchor) {
            case "laptop-phone":
              webOmniApp.callbacks.startAnimation("comp");
              break;
            case "laptop-tablet":
              webOmniApp.callbacks.startAnimation("comp2");
              break;
            case "phone-tablet":
              webOmniApp.callbacks.startAnimation("comp3");
              break;
          }

          if (slideIndex == 0) {
            $('#header-bar').addClass('styled');
            $('.controlArrow').hide();
          } else {
            $('#header-bar').removeClass('styled');
            $('.controlArrow').show();
          }
        }
      });
    }
  }
,

  initBootstrapTooltip: function () {
    $('[data-toggle=tooltip]').tooltip();
  }
,

  init: function () {
    this.initBootstrapTooltip();
    if ($(window).width() > 600) {
      this.initFullPage();
    }

  }
}
,

init: function () {
  if ($(window).width() > 600) {
    this.appendHome();
  }
  this.appPlugins.init();
  this.attachHandles();

  AdobeEdge.bootstrapCallback(function () {
    comp = AdobeEdge.getComposition('EDGE-88305247').getStage();
    comp2 = AdobeEdge.getComposition('EDGE-88305242').getStage();
    comp3 = AdobeEdge.getComposition('EDGE-88305243').getStage();
  });

}
}
;

$(function () {
  webOmniApp.init();
});


$(window).load(function () {

});
