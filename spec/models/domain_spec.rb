require 'spec_helper'

describe Domain do
  include_context "data"
  
  it "has correct soa record" do
    domain.soa_record.should be_present
  end

  it "has correct ns records" do
    domain.should have(2).ns_records
    for record in domain.ns_records
      record.should be_persisted
    end
  end

  it "has correct records" do
    domain.records.count.should == 3
  end

  it "has a soa serial updated" do
    (domain.soa_record.serial % 10).should == 1
  end
  
  it "updates name to records when name changed" do
    domain.update_attributes(:name => "changed#{domain.name}")
    domain.soa_record.name.should == domain.name
    domain.records.all.size.should == 3
    for record in domain.records.all
      record.name.should =~ /#{domain.name}$/
    end
    (domain.soa_record.serial % 10).should == 0
  end
  
  it "protects DOS on more Settings.max_domains_per_user+ domains" do
    max = Settings.max_domains_per_user.to_i
    domain.stub_chain(:user, :domains, :count).and_return(max)
    domain.max_domains_per_user
    domain.should have(1).errors
  end

  it "is DOS-valid on less than Settings.max_domains_per_user domains" do
    max = Settings.max_domains_per_user.to_i
    domain.stub_chain(:user, :domains, :count).and_return(max-1)
    domain.max_domains_per_user
    domain.should be_valid
  end
  
  it "validates ownership" do
    domain.name = 'co.uk'
    domain.should have(1).errors_on(:name)
    
    domain.name = 'clyfe.ro'
    domain.should be_valid
  end
  
end
