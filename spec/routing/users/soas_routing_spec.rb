require "spec_helper"

describe Users::SoasController do
  describe "routing" do

    it "routes to #index" do
      get("/soas").should route_to("users/soas#index")
    end

    it "routes to #new" do
      get("/soas/new").should route_to("users/soas#new")
    end

    it "routes to #show" do
      get("/soas/1").should route_to("users/soas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/soas/1/edit").should route_to("users/soas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/soas").should route_to("users/soas#create")
    end

    it "routes to #update" do
      put("/soas/1").should route_to("users/soas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/soas/1").should route_to("users/soas#destroy", :id => "1")
    end

  end
end
