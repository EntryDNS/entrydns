require 'spec_helper'

describe User do
  include_context "data"
  it "is valid" do
    user.should be_valid
  end
end
