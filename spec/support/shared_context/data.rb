shared_context "data" do
  
  let(:user){Factory(:user)}
  
  let(:domain){
    domain = Factory.build(:domain, :user => user)
    domain.setup(FactoryGirl.generate(:email))
    domain.save!
    domain.soa_record.update_serial!
    domain
  }
  
  let(:a_record){Factory(:a, :content => '127.0.0.1', :domain => domain)}
  
end
