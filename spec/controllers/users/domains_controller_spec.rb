require 'spec_helper'

describe Users::DomainsController do
  include_context "data"

  before do
    sign_in user
  end

  context "crud" do

    it "creates a new domain" do
      params = { "utf8" => "✓", "commit" => "Create",
        "record" => { "name" => "domain.com", "ip" => "",
          "soa_record" => { "contact" => "user@entrydns.net", ttl: "3600" },
          "ns_records" => { "0" => "",
            "1384548529585" => { "content" => "ns1.entrydns.net", "ttl" => "3600" },
            "1384548529591" => { "content" => "ns2.entrydns.net", "ttl" => "3600" },
            "1384548529660" => { "content" => "ns3.entrydns.net", "ttl" => "3600" }
          }}}
      ->() { post :create, params }.should change(Domain, :count).by(1)
    end

  end

  context "wiring" do

    # a domain who's parent domain is not in our system
    context "domain" do

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
