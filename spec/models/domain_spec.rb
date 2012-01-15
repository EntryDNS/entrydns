require 'spec_helper'

describe Domain do
  include_context "data"
  
  it "has correct soa record" do
    domain.soa_record.should be_present
  end

  it "has correct ns records" do
    domain.should have(Settings.ns.count).ns_records
    for record in domain.ns_records
      record.should be_persisted
    end
  end

  it "has correct records" do
    domain.records.count.should == Settings.ns.count + 1
  end

  it "has a soa serial updated" do
    (domain.soa_record.serial % 10).should == 1
  end
  
  it "updates name to records when name changed" do
    domain.update_attributes(:name => "changed#{domain.name}")
    domain.soa_record.name.should == domain.name
    domain.records.all.size.should == Settings.ns.count + 1
    for record in domain.records.all
      record.name.should =~ /#{domain.name}$/
    end
    (domain.soa_record.serial % 10).should == 0
  end
  
  it "protects DOS on more Settings.max_domains_per_user+ domains" do
    max = Settings.max_domains_per_user.to_i
    domain.stub_chain('user.domains.count').and_return(max)
    domain.max_domains_per_user
    domain.should have(1).errors
  end

  it "is DOS-valid on less than Settings.max_domains_per_user domains" do
    max = Settings.max_domains_per_user.to_i
    domain.stub_chain('user.domains.count').and_return(max - 1)
    domain.max_domains_per_user
    domain.should be_valid
  end
  
  it "has parent_domain" do
    subdomain = build(:domain, :user => other_user, :name => "x.#{domain.name}")
    subdomain.parent_domain.should == domain
  end
  
  it "validates ownership" do
    domain.name = 'co.uk'
    domain.should have(1).errors_on(:name)

    domain.name = 'clyfe.ro'
    domain.should be_valid

    User.do_as(user) do
      # stub a parent domain on another user account, with no permissions present
      mock_domain = mock(:user_id => third_user.id, :user => third_user, :name => 'x')
      domain.stub(:parent_domain).and_return(mock_domain)
      domain.should have(1).errors_on(:name)
    end
  end

  it "queries domains corectly in index" do
    wheres = Domain.accessible_by(user.ability).where_values
    joins = Domain.accessible_by(user.ability).joins_values.map{|j| [j._name, j._type]}
    wheres.should == ["(`permissions`.`user_id` = #{user.id}) OR (`domains`.`user_id` = #{user.id})"]
    joins.should == [[:permissions, Arel::Nodes::OuterJoin]]
  end
  
  it "has reversed name" do
    domain.name_reversed.should be_present
    domain.name_reversed.should == domain.name.reverse
  end
  
end
