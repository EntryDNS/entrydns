class RecordsController < ApplicationController
  # override so SOA's cannot be created by themselves
  def self._add_sti_create_links
    new_action_link = active_scaffold_config.action_links.collection['new']
    unless new_action_link.nil? || active_scaffold_config.sti_children.empty?
      active_scaffold_config.action_links.collection.delete('new')
      sti_children = active_scaffold_config.sti_children - [:SOA]
      sti_children.each do |child|
        new_sti_link = Marshal.load(Marshal.dump(new_action_link)) # deep clone
        new_sti_link.label = child.to_s.camelize.constantize.model_name.human
        new_sti_link.parameters = {:parent_sti => controller_path}
        new_sti_link.controller = Proc.new { active_scaffold_controller_for(child.to_s.camelize.constantize).controller_path }
        active_scaffold_config.action_links.collection.create.add(new_sti_link)
      end
      active_scaffold_config.action_links.collection.create.name = "Add Record"
    end
  end
  
  active_scaffold :record do |conf|
    conf.sti_children = [:SOA, :NS, :MX, :A, :CNAME, :TXT]
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.columns[:change_date].list_ui = :timestamp
    conf.columns[:ttl].options = {:i18n_number => {:delimiter => ''}}
    # conf.create.link.label = "Add Record"
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
end
