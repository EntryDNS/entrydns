require 'spec_helper'

describe "txts/edit.html.erb" do
  before(:each) do
    @txt = assign(:txt, stub_model(Txt))
  end

  it "renders the edit txt form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => txts_path(@txt), :method => "post" do
    end
  end
end
