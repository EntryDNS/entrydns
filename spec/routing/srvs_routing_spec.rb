require "spec_helper"

describe SrvsController do
  describe "routing" do

    it "routes to #index" do
      get("/srvs").should route_to("srvs#index")
    end

    it "routes to #new" do
      get("/srvs/new").should route_to("srvs#new")
    end

    it "routes to #show" do
      get("/srvs/1").should route_to("srvs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/srvs/1/edit").should route_to("srvs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/srvs").should route_to("srvs#create")
    end

    it "routes to #update" do
      put("/srvs/1").should route_to("srvs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/srvs/1").should route_to("srvs#destroy", :id => "1")
    end

  end
end
