# encoding: UTF-8

module ApplicationHelper

  FLASH_ALIASES = HashWithIndifferentAccess.new(
    error: :error, success: :success,
    alert: :warning, warning: :warning, warn: :warning,
    info: :info,   notice: :info
  )

  # for each record in the rails flash this
  # function wraps the message in an appropriate div
  # and displays it
  def flash_display(clazz = '')
    flashes = flash.select{|key, msg| msg.present?}.collect { |key, msg|
      content = '<a class="close" data-dismiss="alert">×</a> '.html_safe + msg
      content_tag(:div, content, :class => "alert alert-#{FLASH_ALIASES[key]}")
    }.join
    flashes.present? ? content_tag(:div, flashes.html_safe, :class => clazz) : nil
  end

  def error_messages_for(resource)
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
      :count => resource.errors.count,
      :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def honeypot
    content_tag('div', :style => 'position: absolute; left: -2000px;') do
      text_field_tag("#{Settings.honeypot}", nil, :tabindex => 900)
    end
  end

  # ActiveScaffold

  def active_scaffold_column_timestamp(record, column)
    value = record.send(column.name)
    value.nil? ? nil : Time.at(value)
  end

end
