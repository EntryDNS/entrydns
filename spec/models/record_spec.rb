require 'spec_helper'

describe Record do
  include_context "data"

  it "protects DOS on more Settings.max_records_per_domain+ domains" do
    max = Settings.max_records_per_domain.to_i
    a_record.domain.stub_chain(:records, :count).and_return(max)
    a_record.max_records_per_domain
    a_record.should have(1).errors
  end

  it "is DOS-valid on less than Settings.max_records_per_domain domains" do
    max = Settings.max_records_per_domain.to_i
    a_record.domain.stub_chain(:records, :count).and_return(max)
    a_record.max_records_per_domain
    a_record.should be_valid
  end

  it "queries records corectly in index" do
    permission3
    query = Record.accessible_by(user.ability)
    expected = <<-SQL
    SELECT `records`.* FROM `records`
    INNER JOIN `domains` ON `domains`.`id` = `records`.`domain_id`
    LEFT OUTER JOIN `permissions` ON `permissions`.`domain_id` = `domains`.`id`
    WHERE ((((1=0 OR
      `domains`.`user_id` = #{user.id}) OR
      `permissions`.`user_id` = #{user.id}) OR
      `domains`.`name_reversed` LIKE '#{permission3.domain.name_reversed}.%'))
    SQL
    query.to_sql.should == expected.gsub("\n", '').gsub(/\s+/, ' ').strip
  end

  it "queries A records corectly in index" do
    permission3
    query = A.accessible_by(user.ability(:reload => true))
    expected = <<-SQL
    SELECT `records`.* FROM `records`
    INNER JOIN `domains` ON `domains`.`id` = `records`.`domain_id`
    LEFT OUTER JOIN `permissions` ON `permissions`.`domain_id` = `domains`.`id`
    WHERE `records`.`type` IN ('A') AND (((((1=0 OR
      `domains`.`user_id` = #{user.id}) OR
      `records`.`user_id` = #{user.id}) OR
      `permissions`.`user_id` = #{user.id}) OR
      `domains`.`name_reversed` LIKE '#{permission3.domain.name_reversed}.%'))
    SQL
    query.to_sql.should == expected.gsub("\n", '').gsub(/\s+/, ' ').strip
  end

  it "validates host a records dubles" do
    host_a_record
    host_a_record2 = build(:a, name: host_a_record.name, content: '127.0.0.2', domain: host_domain, user: user2)
    host_a_record2.should have(1).errors_on(:name)
  end

  it "audits creations" do
    PaperTrail.enabled = true
    expect { a_record }.to change(PaperTrail::Version, :count)
    expect { a_record.update!(name: "x.#{a_record.name}") }.to change(PaperTrail::Version, :count).by(1)
    # expect { a_record.update!(content: "127.0.0.2") }.to_not change(PaperTrail::Version, :count)
    PaperTrail.enabled = false
  end

end
