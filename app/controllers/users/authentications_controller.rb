class Users::AuthenticationsController < UsersController
  active_scaffold :authentication do |conf|
    conf.list.columns = [:provider]
    conf.actions.exclude :create, :search, :update, :show
  end
end
