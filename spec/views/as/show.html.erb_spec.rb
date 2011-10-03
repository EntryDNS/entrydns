require 'spec_helper'

describe "as/show.html.erb" do
  before(:each) do
    @a = assign(:a, stub_model(A))
  end

  it "renders attributes in <p>" do
    render
  end
end
