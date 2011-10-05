require 'spec_helper'

describe "txts/new.html.erb" do
  before(:each) do
    assign(:txt, stub_model(Txt).as_new_record)
  end

  it "renders new txt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => txts_path, :method => "post" do
    end
  end
end
