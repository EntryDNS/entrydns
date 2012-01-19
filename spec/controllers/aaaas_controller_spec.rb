require 'spec_helper'

describe AaaasController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Aaaa. As you add validations to Aaaa, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all aaaas as @aaaas" do
      aaaa = Aaaa.create! valid_attributes
      get :index
      assigns(:aaaas).should eq([aaaa])
    end
  end

  describe "GET show" do
    it "assigns the requested aaaa as @aaaa" do
      aaaa = Aaaa.create! valid_attributes
      get :show, :id => aaaa.id.to_s
      assigns(:aaaa).should eq(aaaa)
    end
  end

  describe "GET new" do
    it "assigns a new aaaa as @aaaa" do
      get :new
      assigns(:aaaa).should be_a_new(Aaaa)
    end
  end

  describe "GET edit" do
    it "assigns the requested aaaa as @aaaa" do
      aaaa = Aaaa.create! valid_attributes
      get :edit, :id => aaaa.id.to_s
      assigns(:aaaa).should eq(aaaa)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Aaaa" do
        expect {
          post :create, :aaaa => valid_attributes
        }.to change(Aaaa, :count).by(1)
      end

      it "assigns a newly created aaaa as @aaaa" do
        post :create, :aaaa => valid_attributes
        assigns(:aaaa).should be_a(Aaaa)
        assigns(:aaaa).should be_persisted
      end

      it "redirects to the created aaaa" do
        post :create, :aaaa => valid_attributes
        response.should redirect_to(Aaaa.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved aaaa as @aaaa" do
        # Trigger the behavior that occurs when invalid params are submitted
        Aaaa.any_instance.stub(:save).and_return(false)
        post :create, :aaaa => {}
        assigns(:aaaa).should be_a_new(Aaaa)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Aaaa.any_instance.stub(:save).and_return(false)
        post :create, :aaaa => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested aaaa" do
        aaaa = Aaaa.create! valid_attributes
        # Assuming there are no other aaaas in the database, this
        # specifies that the Aaaa created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Aaaa.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => aaaa.id, :aaaa => {'these' => 'params'}
      end

      it "assigns the requested aaaa as @aaaa" do
        aaaa = Aaaa.create! valid_attributes
        put :update, :id => aaaa.id, :aaaa => valid_attributes
        assigns(:aaaa).should eq(aaaa)
      end

      it "redirects to the aaaa" do
        aaaa = Aaaa.create! valid_attributes
        put :update, :id => aaaa.id, :aaaa => valid_attributes
        response.should redirect_to(aaaa)
      end
    end

    describe "with invalid params" do
      it "assigns the aaaa as @aaaa" do
        aaaa = Aaaa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Aaaa.any_instance.stub(:save).and_return(false)
        put :update, :id => aaaa.id.to_s, :aaaa => {}
        assigns(:aaaa).should eq(aaaa)
      end

      it "re-renders the 'edit' template" do
        aaaa = Aaaa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Aaaa.any_instance.stub(:save).and_return(false)
        put :update, :id => aaaa.id.to_s, :aaaa => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested aaaa" do
      aaaa = Aaaa.create! valid_attributes
      expect {
        delete :destroy, :id => aaaa.id.to_s
      }.to change(Aaaa, :count).by(-1)
    end

    it "redirects to the aaaas list" do
      aaaa = Aaaa.create! valid_attributes
      delete :destroy, :id => aaaa.id.to_s
      response.should redirect_to(aaaas_url)
    end
  end

end
