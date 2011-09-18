class DomainsController < ApplicationController
  active_scaffold :domain do |conf|
    conf.columns = [:name, :master, :last_check, :type, :notified_serial, :account]
  end
end
