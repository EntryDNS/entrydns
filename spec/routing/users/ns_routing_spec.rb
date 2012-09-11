require "spec_helper"

describe Users::NsController do
  describe "routing" do

    it "routes to #index" do
      get("/ns").should route_to("users/ns#index")
    end

    it "routes to #new" do
      get("/ns/new").should route_to("users/ns#new")
    end

    it "routes to #show" do
      get("/ns/1").should route_to("users/ns#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ns/1/edit").should route_to("users/ns#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ns").should route_to("users/ns#create")
    end

    it "routes to #update" do
      put("/ns/1").should route_to("users/ns#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ns/1").should route_to("users/ns#destroy", :id => "1")
    end

  end
end
