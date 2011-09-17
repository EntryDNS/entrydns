require 'spec_helper'

describe "records/edit.html.erb" do
  before(:each) do
    @record = assign(:record, stub_model(Record))
  end

  it "renders the edit record form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => records_path(@record), :method => "post" do
    end
  end
end
