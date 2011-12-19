shared_context "data" do
  
  let(:user){create(:user)}
  
  let(:domain){
    domain = build(:domain, :user => user)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
    domain
  }
  
  let(:a_record){create(:a, :content => '127.0.0.1', :domain => domain)}
  
  let(:soa_record){domain.soa_record}
  
end
