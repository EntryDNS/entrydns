require 'spec_helper'

describe "supermasters/new.html.erb" do
  before(:each) do
    assign(:supermaster, stub_model(Supermaster).as_new_record)
  end

  it "renders new supermaster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => supermasters_path, :method => "post" do
    end
  end
end
