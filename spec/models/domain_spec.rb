require 'spec_helper'

describe Domain do
  let(:domain){Factory(:domain)}
  it "is" do
    domain.should be_valid
  end
end
