require 'spec_helper'

describe "cnames/index.html.erb" do
  before(:each) do
    assign(:cnames, [
      stub_model(Cname),
      stub_model(Cname)
    ])
  end

  it "renders a list of cnames" do
    render
  end
end
