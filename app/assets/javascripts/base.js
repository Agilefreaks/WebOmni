var comp, comp2, comp3;

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
        $deviceContinue: $('#device-continue'),
        $btnReplay: $('.btn-replay')
    },

    appendHome: function () {
        if (!window.location.hash) {
            window.location.hash = '#home';
        }
    },

    runAnimation: function (i, timeline, animList) {
        $(animList).find('.active').removeClass('active');
        $(animList).eq(0).addClass('active');
        setTimeout(function () {
            $(animList + ' li').eq(i).addClass('active').siblings().removeClass('active');
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
        animationTimeline: function (animList) {
            var timeline = 0,
                $animList = $(animList + ' li');

            for (var i = 0; i < $animList.length; i++) {
                timeline = parseInt($animList.eq(i).data('time'), 10) + parseInt(timeline, 10);
                webOmniApp.runAnimation(i, timeline, animList);
            }
        },

        startAnimation: function (comp, animList) {
            setTimeout(function () {
                comp.play("start");
                webOmniApp.callbacks.animationTimeline(animList);
            }, 200);
        },

        goToDevice: function () {
            var $checked = [];
            $('#device-list').find('input:checked').each(function () {
                $checked.push($(this).prop('name'));
            });

            $.fn.fullpage.moveTo(2, $checked[0] + "-" + $checked[1]);
        },

        replayAnimation: function (e) {
            var $this = $(this),
                $listId = '#' + $this.closest('.slide').find('.anim-list').attr('id');

            webOmniApp.callbacks.startAnimation(comp, $listId);
            e.preventDefault();
        }
    },

    attachHandles: function () {
        this.config.$win.resize(webOmniApp.callbacks.resize);
        this.config.$menuTrigger.on('click', webOmniApp.callbacks.toggleMenu);
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
                    easing: 'easeInQuart',
                    onLeave: function (index, nextIndex) {
                        if ($('.section').eq(nextIndex - 1).hasClass('light-bg')) {
                            $('#header-bar').addClass('styled');
                        } else {
                            $('#header-bar').removeClass('styled');
                        }

                        if (nextIndex == "2") {

                            window.location.hash = '#seemore';

                            setTimeout(function () {
                                $('#device-list').addClass('animated fadeInUpBig');
                            }, 500);
                        } else {
                            $('#device-list').removeClass('animated fadeInUpBig');
                        }
                    },

                    afterSlideLoad: function (anchorLink, index, slideAnchor, slideIndex) {

                        switch (slideAnchor) {
                            case "laptop-phone":
                                webOmniApp.callbacks.startAnimation(comp, '#anim1-list');
                                break;
                            case "laptop-tablet":
                                webOmniApp.callbacks.startAnimation(comp2, '#anim2-list');
                                break;
                            case "phone-tablet":
                                webOmniApp.callbacks.startAnimation(comp3, '#anim3-list');
                                break;
                        }

                        if (slideIndex == 0) {
                            $('#header-bar').addClass('styled');
                        } else {
                            $('#header-bar').removeClass('styled');
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

        AdobeEdge.bootstrapCallback(function () {
            comp = AdobeEdge.getComposition('EDGE-88305247').getStage();
            comp2 = AdobeEdge.getComposition('EDGE-88305242').getStage();
            comp3 = AdobeEdge.getComposition('EDGE-88305243').getStage();
        });

    }
};

$(function () {
    webOmniApp.init();
});


$(window).load(function () {

});
