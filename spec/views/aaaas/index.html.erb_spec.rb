require 'spec_helper'

describe "aaaas/index.html.erb" do
  before(:each) do
    assign(:aaaas, [
      stub_model(Aaaa),
      stub_model(Aaaa)
    ])
  end

  it "renders a list of aaaas" do
    render
  end
end
