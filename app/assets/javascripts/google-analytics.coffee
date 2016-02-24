$ ->
  $('a.js-goto-section').on 'click', () ->
    ga('send', 'event', 'Features', 'See more', $(this).data('tracklabel'))

  $('a.button--download').on 'click', () ->
    ga('send', 'event', 'Features', 'Install', $(this).data('tracklabel'))

  $('a.js-omni-video-toggle').on 'click', () ->
    ga('send', 'event', 'Video', 'Play')