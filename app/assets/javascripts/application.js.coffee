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
#= require active_scaffold
#= require slides
#= require twitter/bootstrap
#= require_self

$ ->
  $(document).popover(selector: '[rel=popover]')
  $(document).tooltip(selector: '[rel=tooltip]')
  
  pjaxContainer = '[data-pjax-container]'
  $('.pjax-nav a:not([data-remote]):not([data-behavior]):not([data-skip-pjax])').pjax(pjaxContainer)
  $pjaxContainer = $(pjaxContainer)
  $pjaxContainer.on 'pjax:success', (event, data, status, xhr, options) ->
    $('.pjax-nav').find('li.active').removeClass 'active'
    $(".pjax-nav a[href=\"#{window.location.pathname}\"]").parents('li').addClass 'active'
    if $pjaxContainer.parent().hasClass('container') || $pjaxContainer.find('.container').length > 0
      $pjaxContainer.removeClass 'container'
    else
      $pjaxContainer.addClass 'container'
