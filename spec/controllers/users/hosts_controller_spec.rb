require 'spec_helper'

describe Users::HostsController do
  include_context "data"

  before do
    sign_in user
    @controller.stub(:nested_parent_record => host_domain)
  end

  it "#new_model is wired" do
    @controller.send(:new_model).user.should == user
  end

  it "#before_create_save wires" do
    @controller.send(:before_create_save, host_a_record)
    host_a_record.user.should == user
  end
end
