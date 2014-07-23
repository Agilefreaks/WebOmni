(function ($) {
  var inviewObjects = {},
      d = document,
      w = window,
      documentElement = d.documentElement,
      expando = $.expando;

  $.event.special.inview = {
    add: function(data) {
      inviewObjects[data.guid + "-" + this[expando]] = { data: data, $element: $(this) };
    },

    remove: function(data) {
      try { delete inviewObjects[data.guid + "-" + this[expando]]; } catch(e) {}
    }
  };

  function getInvisiblePercent($element) {
    var rect = $element.getBoundingClientRect();
    var containerHeight = rect.height,
      containerTop = rect.top,
      containerBottom = rect.top + rect.height;

    var percentInvisibleFromTop = 0,
      percentInvisibleFromBottom = 0;
    if (containerTop < 0) {
      percentInvisibleFromTop = ((-containerTop) * 100) / containerHeight;
    }

    var windowHeight = w.innerHeight || documentElement.clientHeight
    if (containerBottom > windowHeight) {
      var outOfViewHeight = (containerBottom - windowHeight)
      percentInvisibleFromBottom = (outOfViewHeight * 100) / containerHeight;
    }

    return percentInvisibleFromTop + percentInvisibleFromBottom;
  }

  function showOrHideElementBasedOnAmountVisible($element, percentInvisible) {
    var inView = $element.data('inview');
    if (percentInvisible < 50) {
      if (!inView) {
        // object has entered viewport
        $element.data('inview', true).trigger('inview', [true]);
      }
    }
    else if (inView) {
      // object has left viewport
      $element.data('inview', false).trigger('inview', [false]);
    }
  }

  function checkInView() {
    // Fuck IE and its quirks, we're doing this the right way.
    var $elements = $();

    $.each(inviewObjects, function(i, inviewObject) {
      var selector  = inviewObject.data.selector,
          $element  = inviewObject.$element;

      $elements = $elements.add(selector ? $element.find(selector) : $element);
    });

    if ($elements.length) {
      for (var i = 0; i < $elements.length; i++) {
        if (!$elements[i]) {
          continue;
        } else if (!$.contains(documentElement, $elements[i])) {
          delete $elements[i];
          continue;
        }

        var $el = $($elements[i]);

        var percentInvisible = getInvisiblePercent($el[0]);

        showOrHideElementBasedOnAmountVisible($el, percentInvisible);
      }
    }
  }

  $(window).on('scroll slimscrolling resize scrollstop ', function(e, data) {
    if ($(inviewObjects).data.selector != "") {
      checkInView();
    }
  });
})(jQuery);