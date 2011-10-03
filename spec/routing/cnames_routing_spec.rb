require "spec_helper"

describe CnamesController do
  describe "routing" do

    it "routes to #index" do
      get("/cnames").should route_to("cnames#index")
    end

    it "routes to #new" do
      get("/cnames/new").should route_to("cnames#new")
    end

    it "routes to #show" do
      get("/cnames/1").should route_to("cnames#show", :id => "1")
    end

    it "routes to #edit" do
      get("/cnames/1/edit").should route_to("cnames#edit", :id => "1")
    end

    it "routes to #create" do
      post("/cnames").should route_to("cnames#create")
    end

    it "routes to #update" do
      put("/cnames/1").should route_to("cnames#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/cnames/1").should route_to("cnames#destroy", :id => "1")
    end

  end
end
