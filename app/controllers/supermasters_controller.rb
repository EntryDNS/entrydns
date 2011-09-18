class SupermastersController < ApplicationController
  active_scaffold :supermaster do |conf|
    conf.columns = [:nameserver, :account]
  end
end
