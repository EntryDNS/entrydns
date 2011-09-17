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
  
end
