require 'spec_helper'

describe "cnames/show.html.erb" do
  before(:each) do
    @cname = assign(:cname, stub_model(Cname))
  end

  it "renders attributes in <p>" do
    render
  end
end
