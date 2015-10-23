require 'spec_helper'

describe User do
  include_context "data"

  it "is valid" do
    user.should be_valid
  end

  it "audits creations" do
    PaperTrail.enabled = true
    expect { user }.to change(PaperTrail::Version, :count)
    PaperTrail.enabled = false
  end
end
