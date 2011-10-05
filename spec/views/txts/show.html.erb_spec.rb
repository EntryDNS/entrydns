require 'spec_helper'

describe "txts/show.html.erb" do
  before(:each) do
    @txt = assign(:txt, stub_model(Txt))
  end

  it "renders attributes in <p>" do
    render
  end
end
