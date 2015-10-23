require 'spec_helper'

__END__

describe Dnsbl do
  include_context "data"

  it "queries correctly" do
    Dnsbl.query('does-not-exist-domain-1234567890.net') == nil
  end

  it "distinguishes bad domains from good ones" do
    Dnsbl.include?('place4porn.net').should == true
    Dnsbl.include?('entrydns.net').should == false
  end

end
