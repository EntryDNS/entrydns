require 'spec_helper'

describe "ns/new.html.erb" do
  before(:each) do
    assign(:ns, stub_model(Ns).as_new_record)
  end

  it "renders new ns form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => ns_index_path, :method => "post" do
    end
  end
end
