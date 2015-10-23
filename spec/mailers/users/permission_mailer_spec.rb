require "spec_helper"

describe Users::PermissionMailer do
  include_context "data"

  it "has sends to the right email" do
    created_mail = Users::PermissionMailer.created(permission)
    created_mail.to.should == [permission.user.email]
    destroyed_mail = Users::PermissionMailer.destroyed(permission)
    destroyed_mail.to.should == [permission.user.email]
  end
end
