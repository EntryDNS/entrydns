require 'spec_helper'

describe "cnames/edit.html.erb" do
  before(:each) do
    @cname = assign(:cname, stub_model(Cname))
  end

  it "renders the edit cname form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cnames_path(@cname), :method => "post" do
    end
  end
end
