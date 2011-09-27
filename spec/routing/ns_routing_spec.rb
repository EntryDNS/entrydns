require "spec_helper"

describe NsController do
  describe "routing" do

    it "routes to #index" do
      get("/ns").should route_to("ns#index")
    end

    it "routes to #new" do
      get("/ns/new").should route_to("ns#new")
    end

    it "routes to #show" do
      get("/ns/1").should route_to("ns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ns/1/edit").should route_to("ns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ns").should route_to("ns#create")
    end

    it "routes to #update" do
      put("/ns/1").should route_to("ns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ns/1").should route_to("ns#destroy", :id => "1")
    end

  end
end
