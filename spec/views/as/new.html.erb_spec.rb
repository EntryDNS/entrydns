require 'spec_helper'

describe "as/new.html.erb" do
  before(:each) do
    assign(:a, stub_model(A).as_new_record)
  end

  it "renders new a form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => as_path, :method => "post" do
    end
  end
end
