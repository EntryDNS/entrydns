require 'spec_helper'

describe Users::DomainsController do
  
  context "wiring" do
    include_context "data"
    
    # a domain who's parent domain is not in our system
    context "domain" do
      before do
        sign_in user
      end

      it "is wired with the current user by #new_model" do
        @controller.send(:new_model).user.should == user
      end
    
      it "is wired with the current user by #before_create_save" do
        domain = build(:domain)
        @controller.send(:before_create_save, domain)
        domain.user.should == user
      end
    end
    
    # a domain who's parent domain is in our system
    context "subdomain" do
      before do
        sign_in user2
      end
      
      it "is wired with the user of the parent domain by #before_create_save" do
        subdomain = build(:domain, :user => user2, :name => "x.#{domain.name}")
        @controller.send(:before_create_save, subdomain)
        subdomain.user.should == user
      end
    end
    
  end
end
