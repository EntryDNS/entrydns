$ ->  
  $(document).popover(selector: '[rel=popover]')
  $(document).tooltip(selector: '[rel=tooltip]')

  # fix for Turbolinks with Bootstrap
  # https://github.com/rails/turbolinks/issues/16
  proto = $.fn.dropdown.Constructor.prototype
  toggle = '[data-toggle=dropdown]'
  $(document)
    .on('click.dropdown touchstart.dropdown.data-api', '.dropdown form', (e) -> e.stopPropagation())
    .on('click.dropdown.data-api touchstart.dropdown.data-api', toggle, proto.toggle)
    .on('keydown.dropdown.data-api touchstart.dropdown.data-api', toggle + ', [role=menu]', proto.keydown)
