require 'spec_helper'

describe "srvs/index.html.erb" do
  before(:each) do
    assign(:srvs, [
      stub_model(Srv),
      stub_model(Srv)
    ])
  end

  it "renders a list of srvs" do
    render
  end
end
