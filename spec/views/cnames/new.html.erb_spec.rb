require 'spec_helper'

describe "cnames/new.html.erb" do
  before(:each) do
    assign(:cname, stub_model(Cname).as_new_record)
  end

  it "renders new cname form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cnames_path, :method => "post" do
    end
  end
end
