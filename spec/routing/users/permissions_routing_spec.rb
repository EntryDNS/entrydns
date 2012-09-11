require "spec_helper"

describe Users::PermissionsController do
  describe "routing" do

    it "routes to #index" do
      get("/permissions").should route_to("users/permissions#index")
    end

    it "routes to #new" do
      get("/permissions/new").should route_to("users/permissions#new")
    end

    it "routes to #show" do
      get("/permissions/1").should route_to("users/permissions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/permissions/1/edit").should route_to("users/permissions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/permissions").should route_to("users/permissions#create")
    end

    it "routes to #update" do
      put("/permissions/1").should route_to("users/permissions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/permissions/1").should route_to("users/permissions#destroy", :id => "1")
    end

  end
end
