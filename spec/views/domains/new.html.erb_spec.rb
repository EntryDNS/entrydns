require 'spec_helper'

describe "domains/new.html.erb" do
  before(:each) do
    assign(:domain, stub_model(Domain).as_new_record)
  end

  it "renders new domain form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => domains_path, :method => "post" do
    end
  end
end
