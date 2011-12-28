require 'spec_helper'

describe "permissions/show.html.erb" do
  before(:each) do
    @permission = assign(:permission, stub_model(Permission))
  end

  it "renders attributes in <p>" do
    render
  end
end
