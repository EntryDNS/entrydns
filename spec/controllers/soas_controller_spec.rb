require 'spec_helper'

describe SoasController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Soa. As you add validations to Soa, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all soas as @soas" do
      soa = Soa.create! valid_attributes
      get :index
      assigns(:soas).should eq([soa])
    end
  end

  describe "GET show" do
    it "assigns the requested soa as @soa" do
      soa = Soa.create! valid_attributes
      get :show, :id => soa.id.to_s
      assigns(:soa).should eq(soa)
    end
  end

  describe "GET new" do
    it "assigns a new soa as @soa" do
      get :new
      assigns(:soa).should be_a_new(Soa)
    end
  end

  describe "GET edit" do
    it "assigns the requested soa as @soa" do
      soa = Soa.create! valid_attributes
      get :edit, :id => soa.id.to_s
      assigns(:soa).should eq(soa)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Soa" do
        expect {
          post :create, :soa => valid_attributes
        }.to change(Soa, :count).by(1)
      end

      it "assigns a newly created soa as @soa" do
        post :create, :soa => valid_attributes
        assigns(:soa).should be_a(Soa)
        assigns(:soa).should be_persisted
      end

      it "redirects to the created soa" do
        post :create, :soa => valid_attributes
        response.should redirect_to(Soa.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved soa as @soa" do
        # Trigger the behavior that occurs when invalid params are submitted
        Soa.any_instance.stub(:save).and_return(false)
        post :create, :soa => {}
        assigns(:soa).should be_a_new(Soa)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Soa.any_instance.stub(:save).and_return(false)
        post :create, :soa => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested soa" do
        soa = Soa.create! valid_attributes
        # Assuming there are no other soas in the database, this
        # specifies that the Soa created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Soa.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => soa.id, :soa => {'these' => 'params'}
      end

      it "assigns the requested soa as @soa" do
        soa = Soa.create! valid_attributes
        put :update, :id => soa.id, :soa => valid_attributes
        assigns(:soa).should eq(soa)
      end

      it "redirects to the soa" do
        soa = Soa.create! valid_attributes
        put :update, :id => soa.id, :soa => valid_attributes
        response.should redirect_to(soa)
      end
    end

    describe "with invalid params" do
      it "assigns the soa as @soa" do
        soa = Soa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Soa.any_instance.stub(:save).and_return(false)
        put :update, :id => soa.id.to_s, :soa => {}
        assigns(:soa).should eq(soa)
      end

      it "re-renders the 'edit' template" do
        soa = Soa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Soa.any_instance.stub(:save).and_return(false)
        put :update, :id => soa.id.to_s, :soa => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested soa" do
      soa = Soa.create! valid_attributes
      expect {
        delete :destroy, :id => soa.id.to_s
      }.to change(Soa, :count).by(-1)
    end

    it "redirects to the soas list" do
      soa = Soa.create! valid_attributes
      delete :destroy, :id => soa.id.to_s
      response.should redirect_to(soas_url)
    end
  end

end
