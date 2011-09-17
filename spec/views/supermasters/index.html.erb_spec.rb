require 'spec_helper'

describe "supermasters/index.html.erb" do
  before(:each) do
    assign(:supermasters, [
      stub_model(Supermaster),
      stub_model(Supermaster)
    ])
  end

  it "renders a list of supermasters" do
    render
  end
end
