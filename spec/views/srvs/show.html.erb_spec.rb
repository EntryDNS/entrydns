require 'spec_helper'

describe "srvs/show.html.erb" do
  before(:each) do
    @srv = assign(:srv, stub_model(Srv))
  end

  it "renders attributes in <p>" do
    render
  end
end
