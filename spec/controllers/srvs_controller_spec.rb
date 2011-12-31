require 'spec_helper'

describe SrvsController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Srv. As you add validations to Srv, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all srvs as @srvs" do
      srv = Srv.create! valid_attributes
      get :index
      assigns(:srvs).should eq([srv])
    end
  end

  describe "GET show" do
    it "assigns the requested srv as @srv" do
      srv = Srv.create! valid_attributes
      get :show, :id => srv.id.to_s
      assigns(:srv).should eq(srv)
    end
  end

  describe "GET new" do
    it "assigns a new srv as @srv" do
      get :new
      assigns(:srv).should be_a_new(Srv)
    end
  end

  describe "GET edit" do
    it "assigns the requested srv as @srv" do
      srv = Srv.create! valid_attributes
      get :edit, :id => srv.id.to_s
      assigns(:srv).should eq(srv)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Srv" do
        expect {
          post :create, :srv => valid_attributes
        }.to change(Srv, :count).by(1)
      end

      it "assigns a newly created srv as @srv" do
        post :create, :srv => valid_attributes
        assigns(:srv).should be_a(Srv)
        assigns(:srv).should be_persisted
      end

      it "redirects to the created srv" do
        post :create, :srv => valid_attributes
        response.should redirect_to(Srv.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved srv as @srv" do
        # Trigger the behavior that occurs when invalid params are submitted
        Srv.any_instance.stub(:save).and_return(false)
        post :create, :srv => {}
        assigns(:srv).should be_a_new(Srv)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Srv.any_instance.stub(:save).and_return(false)
        post :create, :srv => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested srv" do
        srv = Srv.create! valid_attributes
        # Assuming there are no other srvs in the database, this
        # specifies that the Srv created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Srv.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => srv.id, :srv => {'these' => 'params'}
      end

      it "assigns the requested srv as @srv" do
        srv = Srv.create! valid_attributes
        put :update, :id => srv.id, :srv => valid_attributes
        assigns(:srv).should eq(srv)
      end

      it "redirects to the srv" do
        srv = Srv.create! valid_attributes
        put :update, :id => srv.id, :srv => valid_attributes
        response.should redirect_to(srv)
      end
    end

    describe "with invalid params" do
      it "assigns the srv as @srv" do
        srv = Srv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Srv.any_instance.stub(:save).and_return(false)
        put :update, :id => srv.id.to_s, :srv => {}
        assigns(:srv).should eq(srv)
      end

      it "re-renders the 'edit' template" do
        srv = Srv.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Srv.any_instance.stub(:save).and_return(false)
        put :update, :id => srv.id.to_s, :srv => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested srv" do
      srv = Srv.create! valid_attributes
      expect {
        delete :destroy, :id => srv.id.to_s
      }.to change(Srv, :count).by(-1)
    end

    it "redirects to the srvs list" do
      srv = Srv.create! valid_attributes
      delete :destroy, :id => srv.id.to_s
      response.should redirect_to(srvs_url)
    end
  end

end
