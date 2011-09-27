require 'spec_helper'

describe "soas/edit.html.erb" do
  before(:each) do
    @soa = assign(:soa, stub_model(Soa))
  end

  it "renders the edit soa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => soas_path(@soa), :method => "post" do
    end
  end
end
