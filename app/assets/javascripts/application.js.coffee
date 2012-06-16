# This is a manifest file that'll be compiled into including all the files listed below.
# Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
# be included in the compiled file accessible from http:#example.com/assets/application.js
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
#= require jquery
#= require jquery-ui
#= require jquery_ujs
#= require jquery.pjax
#= require pjax/page_triggers
#= require slides
#= require bootstrap
#= require active_scaffold
#= require_self

$ ->
  $(document).popover(selector: '[rel=popover]')
  $(document).tooltip(selector: '[rel=tooltip]')
  
  pjaxContainer = '[data-pjax-container]'
  $('.pjax-nav a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax(pjaxContainer)
  $pjaxContainer = $(pjaxContainer)
  $pjaxContainerParent = $(pjaxContainer).parent()
  $pjaxContainer.on 'pjax:success', (event, data, status, xhr, options) ->
    $('.pjax-nav').find('li.active').removeClass 'active'
    $(".pjax-nav a[href=\"#{window.location.pathname}\"]").parents('li').addClass 'active'
    if $pjaxContainer.find('.container').length > 0
      $pjaxContainerParent.removeClass 'container'
    else
      $pjaxContainerParent.addClass 'container'
