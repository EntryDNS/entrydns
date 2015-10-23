require 'spec_helper'

describe Tld do

  its ".lines" do
    Tld.lines.should be_present
  end

  its ".include" do
    Tld.include?('ro').should be_truthy
    Tld.include?('lt').should be_truthy
    Tld.include?('co.uk').should be_truthy
    Tld.include?('com.au').should be_truthy
    Tld.include?('ANYTHING.ar').should be_truthy
    Tld.include?('pref.fukuoka.jp').should be_truthy
    Tld.include?('any.toyama.jp').should be_truthy

    Tld.include?('clyfe.ro').should be_falsey
    Tld.include?('clyfe.zooz.lt').should be_falsey
  end

end
