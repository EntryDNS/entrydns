require 'spec_helper'

describe BlacklistedDomain do
  include_context "data"

  it "includes blacklisted" do
    blacklisted_domain
    BlacklistedDomain.should include(blacklisted_domain.name)
    BlacklistedDomain.should include("sub.#{blacklisted_domain.name}")
    # BlacklistedDomain.should include("place4porn.net")
    BlacklistedDomain.should_not include(FactoryGirl.generate(:domain_name))
  end
end
