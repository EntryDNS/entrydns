require 'spec_helper'

describe "mxes/new.html.erb" do
  before(:each) do
    assign(:mx, stub_model(Mx).as_new_record)
  end

  it "renders new mx form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => mxes_path, :method => "post" do
    end
  end
end
