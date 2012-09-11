$ ->  
  $(document).popover(selector: '[rel=popover]')
  $(document).tooltip(selector: '[rel=tooltip]')
  
  pjaxContainer = '[data-pjax-container]'
  $pjaxContainer = $(pjaxContainer)
  $pjaxContainerParent = $(pjaxContainer).parent()
  $body = $('body')
  fixLayout = ->
    if $pjaxContainer.find('.container').length > 0
      $pjaxContainerParent.removeClass 'container'
    else
      $pjaxContainerParent.addClass 'container'
    if $body.has('.page-home-section').length > 0
      $body.addClass('with-home-section')
    else
      $body.removeClass('with-home-section')
  fixLayout()
  
  $('.pjax-nav a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax(pjaxContainer)
  $pjaxContainer.on 'pjax:success', (event, data, status, xhr, options) ->
    $('.pjax-nav').find('li.active').removeClass 'active'
    $(".pjax-nav a[href=\"#{window.location.pathname}\"]").parents('li').addClass 'active'
    fixLayout()
