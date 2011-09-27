require 'spec_helper'

describe "ns/index.html.erb" do
  before(:each) do
    assign(:ns, [
      stub_model(Ns),
      stub_model(Ns)
    ])
  end

  it "renders a list of ns" do
    render
  end
end
