require 'spec_helper'

describe Admin do
  include_context "data"

  it "is inactive by default" do
    admin_admin.should_not be_active
  end
end
