require 'spec_helper'

describe "soas/index.html.erb" do
  before(:each) do
    assign(:soas, [
      stub_model(Soa),
      stub_model(Soa)
    ])
  end

  it "renders a list of soas" do
    render
  end
end
