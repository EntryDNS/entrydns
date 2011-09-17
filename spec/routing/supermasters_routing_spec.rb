require "spec_helper"

describe SupermastersController do
  describe "routing" do

    it "routes to #index" do
      get("/supermasters").should route_to("supermasters#index")
    end

    it "routes to #new" do
      get("/supermasters/new").should route_to("supermasters#new")
    end

    it "routes to #show" do
      get("/supermasters/1").should route_to("supermasters#show", :id => "1")
    end

    it "routes to #edit" do
      get("/supermasters/1/edit").should route_to("supermasters#edit", :id => "1")
    end

    it "routes to #create" do
      post("/supermasters").should route_to("supermasters#create")
    end

    it "routes to #update" do
      put("/supermasters/1").should route_to("supermasters#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/supermasters/1").should route_to("supermasters#destroy", :id => "1")
    end

  end
end
