require "spec_helper"

describe TxtsController do
  describe "routing" do

    it "routes to #index" do
      get("/txts").should route_to("txts#index")
    end

    it "routes to #new" do
      get("/txts/new").should route_to("txts#new")
    end

    it "routes to #show" do
      get("/txts/1").should route_to("txts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/txts/1/edit").should route_to("txts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/txts").should route_to("txts#create")
    end

    it "routes to #update" do
      put("/txts/1").should route_to("txts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/txts/1").should route_to("txts#destroy", :id => "1")
    end

  end
end
