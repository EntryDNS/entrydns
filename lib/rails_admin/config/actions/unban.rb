require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      
      class Unban < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end
        
        register_instance_option :visible? do
          authorized? && !bindings[:object].active?
        end

        register_instance_option :controller do
          Proc.new do
            @object.unban!
            redirect_to back_or_index
          end
        end

        register_instance_option :link_icon do
          'icon-ok'
        end
      end
      
    end
  end
end