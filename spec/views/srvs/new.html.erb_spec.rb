require 'spec_helper'

describe "srvs/new.html.erb" do
  before(:each) do
    assign(:srv, stub_model(Srv).as_new_record)
  end

  it "renders new srv form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => srvs_path, :method => "post" do
    end
  end
end
