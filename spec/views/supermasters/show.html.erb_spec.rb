require 'spec_helper'

describe "supermasters/show.html.erb" do
  before(:each) do
    @supermaster = assign(:supermaster, stub_model(Supermaster))
  end

  it "renders attributes in <p>" do
    render
  end
end
