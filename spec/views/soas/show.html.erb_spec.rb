require 'spec_helper'

describe "soas/show.html.erb" do
  before(:each) do
    @soa = assign(:soa, stub_model(Soa))
  end

  it "renders attributes in <p>" do
    render
  end
end
