require 'spec_helper'

describe "hosts/edit.html.erb" do
  before(:each) do
    @host = assign(:host, stub_model(Host))
  end

  it "renders the edit host form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hosts_path(@host), :method => "post" do
    end
  end
end
