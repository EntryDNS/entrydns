require 'spec_helper'

describe "txts/index.html.erb" do
  before(:each) do
    assign(:txts, [
      stub_model(Txt),
      stub_model(Txt)
    ])
  end

  it "renders a list of txts" do
    render
  end
end
