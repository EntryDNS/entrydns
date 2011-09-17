require 'spec_helper'

describe "records/show.html.erb" do
  before(:each) do
    @record = assign(:record, stub_model(Record))
  end

  it "renders attributes in <p>" do
    render
  end
end
