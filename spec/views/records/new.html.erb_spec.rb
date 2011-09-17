require 'spec_helper'

describe "records/new.html.erb" do
  before(:each) do
    assign(:record, stub_model(Record).as_new_record)
  end

  it "renders new record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => records_path, :method => "post" do
    end
  end
end
