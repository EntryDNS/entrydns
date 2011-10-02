require 'spec_helper'

describe "mxes/edit.html.erb" do
  before(:each) do
    @mx = assign(:mx, stub_model(Mx))
  end

  it "renders the edit mx form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mxes_path(@mx), :method => "post" do
    end
  end
end
