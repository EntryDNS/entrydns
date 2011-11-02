require "spec_helper"

describe AaaasController do
  describe "routing" do

    it "routes to #index" do
      get("/aaaas").should route_to("aaaas#index")
    end

    it "routes to #new" do
      get("/aaaas/new").should route_to("aaaas#new")
    end

    it "routes to #show" do
      get("/aaaas/1").should route_to("aaaas#show", :id => "1")
    end

    it "routes to #edit" do
      get("/aaaas/1/edit").should route_to("aaaas#edit", :id => "1")
    end

    it "routes to #create" do
      post("/aaaas").should route_to("aaaas#create")
    end

    it "routes to #update" do
      put("/aaaas/1").should route_to("aaaas#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/aaaas/1").should route_to("aaaas#destroy", :id => "1")
    end

  end
end
