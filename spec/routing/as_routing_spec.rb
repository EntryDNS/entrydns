require "spec_helper"

describe AsController do
  describe "routing" do

    it "routes to #index" do
      get("/as").should route_to("as#index")
    end

    it "routes to #new" do
      get("/as/new").should route_to("as#new")
    end

    it "routes to #show" do
      get("/as/1").should route_to("as#show", :id => "1")
    end

    it "routes to #edit" do
      get("/as/1/edit").should route_to("as#edit", :id => "1")
    end

    it "routes to #create" do
      post("/as").should route_to("as#create")
    end

    it "routes to #update" do
      put("/as/1").should route_to("as#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/as/1").should route_to("as#destroy", :id => "1")
    end

  end
end
