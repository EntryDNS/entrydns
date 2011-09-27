require 'spec_helper'

describe "ns/show.html.erb" do
  before(:each) do
    @ns = assign(:ns, stub_model(Ns))
  end

  it "renders attributes in <p>" do
    render
  end
end
