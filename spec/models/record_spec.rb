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
end
