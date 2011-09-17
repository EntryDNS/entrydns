require 'spec_helper'

describe "domains/index.html.erb" do
  before(:each) do
    assign(:domains, [
      stub_model(Domain),
      stub_model(Domain)
    ])
  end

  it "renders a list of domains" do
    render
  end
end
