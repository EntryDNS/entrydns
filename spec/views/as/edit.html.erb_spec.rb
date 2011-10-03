require 'spec_helper'

describe "as/edit.html.erb" do
  before(:each) do
    @a = assign(:a, stub_model(A))
  end

  it "renders the edit a form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => as_path(@a), :method => "post" do
    end
  end
end
