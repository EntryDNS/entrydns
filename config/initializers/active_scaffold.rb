require 'active_scaffold/bridges/cancan/cancan_bridge.rb'

ActiveScaffold.js_framework = :jquery

ActiveScaffold.set_defaults do |conf|
  conf.security.default_permission = false
  # conf.cache_action_link_urls = false
  ActiveScaffold::Config::Mark.mark_all_mode = :page
end

ActiveScaffold::Bridges::PaperTrail.instance_eval do
  def install?
    false
  end
end
