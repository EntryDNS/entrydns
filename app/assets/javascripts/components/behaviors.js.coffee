$document = $(document)

$document.on 'mouseenter', '[rel=tooltip]', -> $(@).tooltip('show')
$document.on 'mouseleave', '[rel=tooltip]', -> $(@).tooltip('hide')

$document.popover(selector: '[rel=popover]', trigger: 'hover', html: true)
