require 'spec_helper'

describe Domain do
  let(:domain){
    domain = Factory.build(:domain)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain
  }
  
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
  
  it "updates name to records when name changed" do
    domain.update_attributes(:name => "changed#{domain.name}")
    domain.soa_record.name.should == domain.name
    domain.records.all.size.should == 3
    for record in domain.records.all
      record.name.should =~ /#{domain.name}$/
    end
  end
end
