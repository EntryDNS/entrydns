require 'spec_helper'

describe "hosts/new.html.erb" do
  before(:each) do
    assign(:host, stub_model(Host).as_new_record)
  end

  it "renders new host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hosts_path, :method => "post" do
    end
  end
end
