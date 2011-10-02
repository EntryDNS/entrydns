require 'spec_helper'

describe "mxes/show.html.erb" do
  before(:each) do
    @mx = assign(:mx, stub_model(Mx))
  end

  it "renders attributes in <p>" do
    render
  end
end
