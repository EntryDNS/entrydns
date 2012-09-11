require "spec_helper"

describe Users::SrvsController do
  describe "routing" do

    it "routes to #index" do
      get("/srvs").should route_to("users/srvs#index")
    end

    it "routes to #new" do
      get("/srvs/new").should route_to("users/srvs#new")
    end

    it "routes to #show" do
      get("/srvs/1").should route_to("users/srvs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/srvs/1/edit").should route_to("users/srvs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/srvs").should route_to("users/srvs#create")
    end

    it "routes to #update" do
      put("/srvs/1").should route_to("users/srvs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/srvs/1").should route_to("users/srvs#destroy", :id => "1")
    end

  end
end
