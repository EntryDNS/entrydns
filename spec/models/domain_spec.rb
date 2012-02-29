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
    domain.records.count.should == Settings.ns.count + 1
    domain.records.each do |record|
      record.name.should =~ /#{domain.name}$/
    end
    (domain.soa_record.serial % 10).should == 0
  end
  
  it "protects DOS on more Settings.max_domains_per_user+ domains" do
    max = Settings.max_domains_per_user.to_i
    domain.user.stub_chain('domains.count').and_return(max)
    domain.max_domains_per_user
    domain.should have(1).errors
  end

  it "is DOS-valid on less than Settings.max_domains_per_user domains" do
    max = Settings.max_domains_per_user.to_i
    domain.user.stub_chain('domains.count').and_return(max - 1)
    domain.max_domains_per_user
    domain.should be_valid
  end

  it "skips DOS protection if host domains" do
    max = Settings.max_domains_per_user.to_i
    host_domain.user.stub_chain('domains.count').and_return(max)
    host_domain.max_domains_per_user
    host_domain.should be_valid
  end
  
  it "has parent_domain" do
    subdomain = build(:domain, :user => user2, :name => "x.#{domain.name}")
    subdomain.parent_domain.should == domain
  end
  
  it "validates ownership" do
    domain.name = 'co.uk'
    domain.should have(1).errors_on(:name)

    domain.name = 'clyfe.ro'
    domain.should be_valid

    User.do_as(user) do
      # stub a parent domain on another user account, with no permissions present
      mock_domain = mock(
        :user_id => user3.id, 
        :user => user3, 
        :name => 'x',
        :can_be_managed_by_current_user? => false
      )
      domain.stub(:parent_domain).and_return(mock_domain)
      domain.should have(1).errors_on(:name)
    end
  end

  it "queries domains corectly in index" do
    permission3
    query = Domain.accessible_by(user.ability(:reload => true))
    expected = <<-SQL
      SELECT `domains`.* FROM `domains` 
      LEFT OUTER JOIN `permissions` ON `permissions`.`domain_id` = `domains`.`id`
      WHERE ((((1=0 OR 
        `domains`.`user_id` = #{user.id}) OR 
        `permissions`.`user_id` = #{user.id}) OR 
        `domains`.`name_reversed` LIKE '#{permission3.domain.name_reversed}.%'))
    SQL
    query.to_sql.should == expected.gsub("\n", '').gsub(/\s+/, ' ').strip
  end
  
  it "has reversed name" do
    domain.name_reversed.should be_present
    domain.name_reversed.should == domain.name.reverse
  end
  
end
