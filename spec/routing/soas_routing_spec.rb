require "spec_helper"

describe SoasController do
  describe "routing" do

    it "routes to #index" do
      get("/soas").should route_to("soas#index")
    end

    it "routes to #new" do
      get("/soas/new").should route_to("soas#new")
    end

    it "routes to #show" do
      get("/soas/1").should route_to("soas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/soas/1/edit").should route_to("soas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/soas").should route_to("soas#create")
    end

    it "routes to #update" do
      put("/soas/1").should route_to("soas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/soas/1").should route_to("soas#destroy", :id => "1")
    end

  end
end
