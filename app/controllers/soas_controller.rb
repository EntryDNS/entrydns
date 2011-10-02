class SoasController < ApplicationController
  active_scaffold :soa do |conf|
    conf.list.columns = [:name, :type, :content, :ttl, :prio, :change_date]
    conf.create.columns = [:contact, :ttl]
    conf.update.columns = [:contact, :ttl]
    conf.columns[:change_date].list_ui = :timestamp
    conf.actions.exclude :delete, :show
  end
end
