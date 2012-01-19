require 'spec_helper'

describe NsController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Ns. As you add validations to Ns, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all ns as @ns" do
      ns = Ns.create! valid_attributes
      get :index
      assigns(:ns).should eq([ns])
    end
  end

  describe "GET show" do
    it "assigns the requested ns as @ns" do
      ns = Ns.create! valid_attributes
      get :show, :id => ns.id.to_s
      assigns(:ns).should eq(ns)
    end
  end

  describe "GET new" do
    it "assigns a new ns as @ns" do
      get :new
      assigns(:ns).should be_a_new(Ns)
    end
  end

  describe "GET edit" do
    it "assigns the requested ns as @ns" do
      ns = Ns.create! valid_attributes
      get :edit, :id => ns.id.to_s
      assigns(:ns).should eq(ns)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Ns" do
        expect {
          post :create, :ns => valid_attributes
        }.to change(Ns, :count).by(1)
      end

      it "assigns a newly created ns as @ns" do
        post :create, :ns => valid_attributes
        assigns(:ns).should be_a(Ns)
        assigns(:ns).should be_persisted
      end

      it "redirects to the created ns" do
        post :create, :ns => valid_attributes
        response.should redirect_to(Ns.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved ns as @ns" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ns.any_instance.stub(:save).and_return(false)
        post :create, :ns => {}
        assigns(:ns).should be_a_new(Ns)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Ns.any_instance.stub(:save).and_return(false)
        post :create, :ns => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested ns" do
        ns = Ns.create! valid_attributes
        # Assuming there are no other ns in the database, this
        # specifies that the Ns created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Ns.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => ns.id, :ns => {'these' => 'params'}
      end

      it "assigns the requested ns as @ns" do
        ns = Ns.create! valid_attributes
        put :update, :id => ns.id, :ns => valid_attributes
        assigns(:ns).should eq(ns)
      end

      it "redirects to the ns" do
        ns = Ns.create! valid_attributes
        put :update, :id => ns.id, :ns => valid_attributes
        response.should redirect_to(ns)
      end
    end

    describe "with invalid params" do
      it "assigns the ns as @ns" do
        ns = Ns.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Ns.any_instance.stub(:save).and_return(false)
        put :update, :id => ns.id.to_s, :ns => {}
        assigns(:ns).should eq(ns)
      end

      it "re-renders the 'edit' template" do
        ns = Ns.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Ns.any_instance.stub(:save).and_return(false)
        put :update, :id => ns.id.to_s, :ns => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested ns" do
      ns = Ns.create! valid_attributes
      expect {
        delete :destroy, :id => ns.id.to_s
      }.to change(Ns, :count).by(-1)
    end

    it "redirects to the ns list" do
      ns = Ns.create! valid_attributes
      delete :destroy, :id => ns.id.to_s
      response.should redirect_to(ns_index_url)
    end
  end

end
