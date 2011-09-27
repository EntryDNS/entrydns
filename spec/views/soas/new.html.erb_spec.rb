require 'spec_helper'

describe "soas/new.html.erb" do
  before(:each) do
    assign(:soa, stub_model(Soa).as_new_record)
  end

  it "renders new soa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => soas_path, :method => "post" do
    end
  end
end
