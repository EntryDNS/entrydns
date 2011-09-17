require 'spec_helper'

describe "records/index.html.erb" do
  before(:each) do
    assign(:records, [
      stub_model(Record),
      stub_model(Record)
    ])
  end

  it "renders a list of records" do
    render
  end
end
