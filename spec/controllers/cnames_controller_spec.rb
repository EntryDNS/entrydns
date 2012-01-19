require 'spec_helper'

describe CnamesController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Cname. As you add validations to Cname, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all cnames as @cnames" do
      cname = Cname.create! valid_attributes
      get :index
      assigns(:cnames).should eq([cname])
    end
  end

  describe "GET show" do
    it "assigns the requested cname as @cname" do
      cname = Cname.create! valid_attributes
      get :show, :id => cname.id.to_s
      assigns(:cname).should eq(cname)
    end
  end

  describe "GET new" do
    it "assigns a new cname as @cname" do
      get :new
      assigns(:cname).should be_a_new(Cname)
    end
  end

  describe "GET edit" do
    it "assigns the requested cname as @cname" do
      cname = Cname.create! valid_attributes
      get :edit, :id => cname.id.to_s
      assigns(:cname).should eq(cname)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cname" do
        expect {
          post :create, :cname => valid_attributes
        }.to change(Cname, :count).by(1)
      end

      it "assigns a newly created cname as @cname" do
        post :create, :cname => valid_attributes
        assigns(:cname).should be_a(Cname)
        assigns(:cname).should be_persisted
      end

      it "redirects to the created cname" do
        post :create, :cname => valid_attributes
        response.should redirect_to(Cname.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cname as @cname" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cname.any_instance.stub(:save).and_return(false)
        post :create, :cname => {}
        assigns(:cname).should be_a_new(Cname)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cname.any_instance.stub(:save).and_return(false)
        post :create, :cname => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cname" do
        cname = Cname.create! valid_attributes
        # Assuming there are no other cnames in the database, this
        # specifies that the Cname created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cname.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => cname.id, :cname => {'these' => 'params'}
      end

      it "assigns the requested cname as @cname" do
        cname = Cname.create! valid_attributes
        put :update, :id => cname.id, :cname => valid_attributes
        assigns(:cname).should eq(cname)
      end

      it "redirects to the cname" do
        cname = Cname.create! valid_attributes
        put :update, :id => cname.id, :cname => valid_attributes
        response.should redirect_to(cname)
      end
    end

    describe "with invalid params" do
      it "assigns the cname as @cname" do
        cname = Cname.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cname.any_instance.stub(:save).and_return(false)
        put :update, :id => cname.id.to_s, :cname => {}
        assigns(:cname).should eq(cname)
      end

      it "re-renders the 'edit' template" do
        cname = Cname.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cname.any_instance.stub(:save).and_return(false)
        put :update, :id => cname.id.to_s, :cname => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cname" do
      cname = Cname.create! valid_attributes
      expect {
        delete :destroy, :id => cname.id.to_s
      }.to change(Cname, :count).by(-1)
    end

    it "redirects to the cnames list" do
      cname = Cname.create! valid_attributes
      delete :destroy, :id => cname.id.to_s
      response.should redirect_to(cnames_url)
    end
  end

end
