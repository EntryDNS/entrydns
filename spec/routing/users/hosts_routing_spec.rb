require "spec_helper"

describe Users::HostsController do
  describe "routing" do

    it "routes to #index" do
      get("/hosts").should route_to("users/hosts#index")
    end

    it "routes to #new" do
      get("/hosts/new").should route_to("users/hosts#new")
    end

    it "routes to #show" do
      get("/hosts/1").should route_to("users/hosts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hosts/1/edit").should route_to("users/hosts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hosts").should route_to("users/hosts#create")
    end

    it "routes to #update" do
      put("/hosts/1").should route_to("users/hosts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hosts/1").should route_to("users/hosts#destroy", :id => "1")
    end

  end
end
