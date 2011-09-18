class RecordsController < ApplicationController
  active_scaffold :record do |conf|
    conf.columns = [:name, :type, :content, :ttl, :prio, :change_date]
  end
end
