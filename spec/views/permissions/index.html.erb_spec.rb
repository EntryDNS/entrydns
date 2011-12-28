require 'spec_helper'

describe "permissions/index.html.erb" do
  before(:each) do
    assign(:permissions, [
      stub_model(Permission),
      stub_model(Permission)
    ])
  end

  it "renders a list of permissions" do
    render
  end
end
