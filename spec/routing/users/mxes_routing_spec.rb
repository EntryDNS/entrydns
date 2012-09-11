require "spec_helper"

describe Users::MxesController do
  describe "routing" do

    it "routes to #index" do
      get("/mxes").should route_to("users/mxes#index")
    end

    it "routes to #new" do
      get("/mxes/new").should route_to("users/mxes#new")
    end

    it "routes to #show" do
      get("/mxes/1").should route_to("users/mxes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/mxes/1/edit").should route_to("users/mxes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/mxes").should route_to("users/mxes#create")
    end

    it "routes to #update" do
      put("/mxes/1").should route_to("users/mxes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/mxes/1").should route_to("users/mxes#destroy", :id => "1")
    end

  end
end
