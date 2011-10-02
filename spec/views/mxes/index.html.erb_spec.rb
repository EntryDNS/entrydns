require 'spec_helper'

describe "mxes/index.html.erb" do
  before(:each) do
    assign(:mxes, [
      stub_model(Mx),
      stub_model(Mx)
    ])
  end

  it "renders a list of mxes" do
    render
  end
end
