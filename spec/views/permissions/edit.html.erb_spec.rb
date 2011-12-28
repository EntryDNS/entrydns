require 'spec_helper'

describe "permissions/edit.html.erb" do
  before(:each) do
    @permission = assign(:permission, stub_model(Permission))
  end

  it "renders the edit permission form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => permissions_path(@permission), :method => "post" do
    end
  end
end
