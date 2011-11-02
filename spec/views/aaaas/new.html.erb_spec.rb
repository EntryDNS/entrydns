require 'spec_helper'

describe "aaaas/new.html.erb" do
  before(:each) do
    assign(:aaaa, stub_model(Aaaa).as_new_record)
  end

  it "renders new aaaa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => aaaas_path, :method => "post" do
    end
  end
end
