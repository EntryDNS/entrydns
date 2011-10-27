require 'spec_helper'

describe Tld do

  its ".lines" do
   Tld.lines.should be_present
  end

  its ".include" do
    Tld.include?('ro').should be_true
    Tld.include?('lt').should be_true
    Tld.include?('co.uk').should be_true
    Tld.include?('com.au').should be_true
    Tld.include?('ANYTHING.ar').should be_true
    Tld.include?('pref.fukuoka.jp').should be_true
    Tld.include?('any.toyama.jp').should be_true
    
    Tld.include?('clyfe.ro').should be_false
    Tld.include?('clyfe.zooz.lt').should be_false
  end

end
