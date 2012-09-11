require "spec_helper"

describe Users::DomainsController do
  describe "routing" do

    it "routes to #index" do
      get("/domains").should route_to("users/domains#index")
    end

    it "routes to #new" do
      get("/domains/new").should route_to("users/domains#new")
    end

    it "routes to #show" do
      get("/domains/1").should route_to("users/domains#show", :id => "1")
    end

    it "routes to #edit" do
      get("/domains/1/edit").should route_to("users/domains#edit", :id => "1")
    end

    it "routes to #create" do
      post("/domains").should route_to("users/domains#create")
    end

    it "routes to #update" do
      put("/domains/1").should route_to("users/domains#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/domains/1").should route_to("users/domains#destroy", :id => "1")
    end

  end
end
