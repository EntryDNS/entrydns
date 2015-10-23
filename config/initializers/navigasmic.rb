Navigasmic.setup do |config|
  config.highlighted_class = 'active'
  config.with_group_class = 'dropdown-menu'
end

module Navigasmic
  # lazy monkey patch, makes it work with twitter bootstrap
  class HtmlNavigationBuilder

    def item(label = '', options = {}, &proc)
      buffer = block_given? ? template.capture(self, &proc) : ''
      label = (label + buffer).html_safe

      item = NavigationItem.new(label, options, template)

      options[:html] ||= {}
      options[:html][:class] = template.add_html_class(options[:html][:class], Navigasmic.disabled_class) if item.disabled?
      options[:html][:class] = template.add_html_class(options[:html][:class], Navigasmic.highlighted_class) if item.highlighted?(template.request.path, template.params, template)

      label = label_for_item(label)
      link = item.link.is_a?(Proc) ? template.instance_eval(&item.link) : item.link

      label = template.link_to(label, link, options.delete(:link_html)) unless !item.link? || item.disabled?

      item.hidden? ? '' : template.content_tag(Navigasmic.item_tag, label, options.delete(:html))
    end

    def group(options = {}, &proc)
      raise ArgumentError, "Missing block" unless block_given?

      options[:html] ||= {}
      options[:html][:class] = template.add_html_class(options[:html][:class], Navigasmic.with_group_class)

      buffer = template.capture(self, &proc)
      group = template.content_tag(Navigasmic.group_tag, buffer, options.delete(:html))

      visible = options[:hidden_unless].nil? ? true : options[:hidden_unless].is_a?(Proc) ? template.instance_eval(&options[:hidden_unless]) : options[:hidden_unless]
      visible ? group.html_safe : ''
    end

  end
end
