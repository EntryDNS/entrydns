require 'spec_helper'

describe "aaaas/show.html.erb" do
  before(:each) do
    @aaaa = assign(:aaaa, stub_model(Aaaa))
  end

  it "renders attributes in <p>" do
    render
  end
end
