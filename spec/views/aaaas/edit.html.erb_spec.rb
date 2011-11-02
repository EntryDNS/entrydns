require 'spec_helper'

describe "aaaas/edit.html.erb" do
  before(:each) do
    @aaaa = assign(:aaaa, stub_model(Aaaa))
  end

  it "renders the edit aaaa form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => aaaas_path(@aaaa), :method => "post" do
    end
  end
end
