require 'spec_helper'

describe "supermasters/edit.html.erb" do
  before(:each) do
    @supermaster = assign(:supermaster, stub_model(Supermaster))
  end

  it "renders the edit supermaster form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => supermasters_path(@supermaster), :method => "post" do
    end
  end
end
