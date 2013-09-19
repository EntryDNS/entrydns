require 'spec_helper'

describe BlacklistedDomain do
  include_context "data"

  it "includes blacklisted", focus: true do
    blacklisted_domain
    BlacklistedDomain.should include(blacklisted_domain.name)
    BlacklistedDomain.should include("sub.#{blacklisted_domain.name}")
    BlacklistedDomain.should_not include(FactoryGirl.generate(:domain_name))
  end
end
