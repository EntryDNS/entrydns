class NsController < ApplicationController
  active_scaffold :ns do |conf|
    conf.list.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.create.columns = [:content, :ttl]
    conf.update.columns = [:content, :ttl]
    conf.columns[:content].label = 'NS'
    conf.columns[:change_date].list_ui = :timestamp
    conf.actions.exclude :show
  end
  before_filter :ensure_nested_under_domain
end
