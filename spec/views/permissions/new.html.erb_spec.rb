require 'spec_helper'

describe "permissions/new.html.erb" do
  before(:each) do
    assign(:permission, stub_model(Permission).as_new_record)
  end

  it "renders new permission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => permissions_path, :method => "post" do
    end
  end
end
