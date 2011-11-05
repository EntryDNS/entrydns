require 'spec_helper'

describe "srvs/edit.html.erb" do
  before(:each) do
    @srv = assign(:srv, stub_model(Srv))
  end

  it "renders the edit srv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => srvs_path(@srv), :method => "post" do
    end
  end
end
