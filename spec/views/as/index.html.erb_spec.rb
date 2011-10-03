require 'spec_helper'

describe "as/index.html.erb" do
  before(:each) do
    assign(:as, [
      stub_model(A),
      stub_model(A)
    ])
  end

  it "renders a list of as" do
    render
  end
end
