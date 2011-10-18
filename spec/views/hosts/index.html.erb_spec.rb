require 'spec_helper'

describe "hosts/index.html.erb" do
  before(:each) do
    assign(:hosts, [
      stub_model(Host),
      stub_model(Host)
    ])
  end

  it "renders a list of hosts" do
    render
  end
end
