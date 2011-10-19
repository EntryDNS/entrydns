module ApplicationHelper

  # for each record in the rails flash this
  # function wraps the message in an appropriate div
  # and displays it
  def flash_display(clazz = '')
    flashes = flash.select{|key, msg| msg.present?}.collect { |key, msg|
      content_tag :div, (content_tag :p, msg), :class => "message #{key}"
    }.join
    if flashes.present?
      content_tag :div, flashes.html_safe, :class => clazz
    else
      nil
    end
  end
  
  def active_scaffold_column_timestamp(column, record)
    value = record.send(column.name)
    value.nil? ? nil : Time.at(value)
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
  
end
