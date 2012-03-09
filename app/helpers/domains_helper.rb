module DomainsHelper
  def domain_list_row_class(record)
    cannot?(:crud_permissions, record) ? "shared-domain" : ''
  end
  
  # Makes a link out of domain name.
  # Indents and dedents to create a tree structure,
  # assuming that the records are sorted in preorder.
  # Adds a visual cue if the record is shared via permissions feature.
  def domain_name_column(record)
    elements = []
    depth = record.depth
    if depth > 1 && @previous_record && record.subdomain_of?(@previous_record)
      (depth - 2).times do # indent
        elements << '<span class="ui-icon ui-icon-blank"></span>'
      end
      elements << '<span class="ui-icon ui-icon-carat-1-sw"></span>'
    end
    elements << link_to(record.name, "http://#{record.name}")
    unless can?(:crud_permissions, record)
      who = "<strong>#{record.user.name}</strong> #{mail_to(record.user.email)}"
      elements << <<-HTM
        <i class="icon-share" rel="popover" data-original-title="Shared domain"
          data-content="This domain was shared with you by #{h who}"></i>
      HTM
    end
    @previous_record = record
    elements.join.html_safe
  end
end