require 'spec_helper'

describe "domains/show.html.erb" do
  before(:each) do
    @domain = assign(:domain, stub_model(Domain))
  end

  it "renders attributes in <p>" do
    render
  end
end
