require "spec_helper"

describe Users::AuthenticationsController do
  describe "routing" do

    it "routes to #index" do
      get("/authentications").should route_to("users/authentications#index")
    end

    it "routes to #destroy" do
      delete("/authentications/1").should route_to("users/authentications#destroy", :id => "1")
    end

  end
end
