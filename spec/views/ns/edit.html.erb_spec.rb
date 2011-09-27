require 'spec_helper'

describe "ns/edit.html.erb" do
  before(:each) do
    @ns = assign(:ns, stub_model(Ns))
  end

  it "renders the edit ns form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ns_index_path(@ns), :method => "post" do
    end
  end
end
