require 'spec_helper'

describe TxtsController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Txt. As you add validations to Txt, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all txts as @txts" do
      txt = Txt.create! valid_attributes
      get :index
      assigns(:txts).should eq([txt])
    end
  end

  describe "GET show" do
    it "assigns the requested txt as @txt" do
      txt = Txt.create! valid_attributes
      get :show, :id => txt.id.to_s
      assigns(:txt).should eq(txt)
    end
  end

  describe "GET new" do
    it "assigns a new txt as @txt" do
      get :new
      assigns(:txt).should be_a_new(Txt)
    end
  end

  describe "GET edit" do
    it "assigns the requested txt as @txt" do
      txt = Txt.create! valid_attributes
      get :edit, :id => txt.id.to_s
      assigns(:txt).should eq(txt)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Txt" do
        expect {
          post :create, :txt => valid_attributes
        }.to change(Txt, :count).by(1)
      end

      it "assigns a newly created txt as @txt" do
        post :create, :txt => valid_attributes
        assigns(:txt).should be_a(Txt)
        assigns(:txt).should be_persisted
      end

      it "redirects to the created txt" do
        post :create, :txt => valid_attributes
        response.should redirect_to(Txt.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved txt as @txt" do
        # Trigger the behavior that occurs when invalid params are submitted
        Txt.any_instance.stub(:save).and_return(false)
        post :create, :txt => {}
        assigns(:txt).should be_a_new(Txt)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Txt.any_instance.stub(:save).and_return(false)
        post :create, :txt => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested txt" do
        txt = Txt.create! valid_attributes
        # Assuming there are no other txts in the database, this
        # specifies that the Txt created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Txt.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => txt.id, :txt => {'these' => 'params'}
      end

      it "assigns the requested txt as @txt" do
        txt = Txt.create! valid_attributes
        put :update, :id => txt.id, :txt => valid_attributes
        assigns(:txt).should eq(txt)
      end

      it "redirects to the txt" do
        txt = Txt.create! valid_attributes
        put :update, :id => txt.id, :txt => valid_attributes
        response.should redirect_to(txt)
      end
    end

    describe "with invalid params" do
      it "assigns the txt as @txt" do
        txt = Txt.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Txt.any_instance.stub(:save).and_return(false)
        put :update, :id => txt.id.to_s, :txt => {}
        assigns(:txt).should eq(txt)
      end

      it "re-renders the 'edit' template" do
        txt = Txt.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Txt.any_instance.stub(:save).and_return(false)
        put :update, :id => txt.id.to_s, :txt => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested txt" do
      txt = Txt.create! valid_attributes
      expect {
        delete :destroy, :id => txt.id.to_s
      }.to change(Txt, :count).by(-1)
    end

    it "redirects to the txts list" do
      txt = Txt.create! valid_attributes
      delete :destroy, :id => txt.id.to_s
      response.should redirect_to(txts_url)
    end
  end

end
