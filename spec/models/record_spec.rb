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
  
  def record_joins_expectations(joins)
    # joins == [{:domain => Squeel(:permissions, outer)}]
    joins.size.should == 1
    joins.first.should be_an_instance_of(Hash)
    domain_joins = joins.first[:domain]
    domain_joins.size.should == 1
    domain_joins.first[:domain]._name.should == :permissions
    domain_joins.first[:domain]._type.should == Arel::Nodes::OuterJoin
  end
  
  it "queries records corectly in index" do
    wheres = Record.accessible_by(user.ability).where_values
    joins = Record.accessible_by(user.ability).joins_values
    wheres.should == ["(`permissions`.`user_id` = #{user.id}) OR (`domains`.`user_id` = #{user.id})"]
    record_joins_expectations(joins)
  end
  
  it "queries A records corectly in index" do
    permission3
    query = A.accessible_by(user.ability(:reload => true))
    wheres = query.where_values
    joins = query.joins_values
    wheres.size.should == 2
    wheres.second.should == "(`domains`.`name_reversed` = '#{domain3.name_reversed}.%') OR ((`permissions`.`user_id` = #{user.id}) OR ((`records`.`user_id` = #{user.id}) OR (`domains`.`user_id` = #{user.id})))"
    record_joins_expectations(joins)
  end
  
end
