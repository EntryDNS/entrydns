require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      
      class Ban < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end
        
        register_instance_option :http_methods do
          [:get, :patch]
        end
        
        register_instance_option :visible? do
          authorized? && bindings[:object].active?
        end

        register_instance_option :controller do
          Proc.new do            
            if request.get? # BAN

              respond_to do |format|
                format.html { render 'ban' }
                format.js   { render 'ban', :layout => false }
              end

            elsif request.patch? # PATCH

              redirect_path = nil
              @auditing_adapter && @auditing_adapter.delete_object(@object, @abstract_model, _current_user)
              if @object.ban!
                flash[:success] = t("admin.flash.successful", :name => @model_config.label, :action => t("admin.actions.ban.done"))
                redirect_path = index_path
              else
                flash[:error] = t("admin.flash.error", :name => @model_config.label, :action => t("admin.actions.ban.done"))
                redirect_path = back_or_index
              end

              redirect_to redirect_path

            end
          end
        end

        register_instance_option :link_icon do
          'icon- fa-ban'
        end
      end
      
    end
  end
end