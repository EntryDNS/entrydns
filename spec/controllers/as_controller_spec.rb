require 'spec_helper'

describe AsController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # A. As you add validations to A, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all as as @as" do
      a = A.create! valid_attributes
      get :index
      assigns(:as).should eq([a])
    end
  end

  describe "GET show" do
    it "assigns the requested a as @a" do
      a = A.create! valid_attributes
      get :show, :id => a.id.to_s
      assigns(:a).should eq(a)
    end
  end

  describe "GET new" do
    it "assigns a new a as @a" do
      get :new
      assigns(:a).should be_a_new(A)
    end
  end

  describe "GET edit" do
    it "assigns the requested a as @a" do
      a = A.create! valid_attributes
      get :edit, :id => a.id.to_s
      assigns(:a).should eq(a)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new A" do
        expect {
          post :create, :a => valid_attributes
        }.to change(A, :count).by(1)
      end

      it "assigns a newly created a as @a" do
        post :create, :a => valid_attributes
        assigns(:a).should be_a(A)
        assigns(:a).should be_persisted
      end

      it "redirects to the created a" do
        post :create, :a => valid_attributes
        response.should redirect_to(A.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved a as @a" do
        # Trigger the behavior that occurs when invalid params are submitted
        A.any_instance.stub(:save).and_return(false)
        post :create, :a => {}
        assigns(:a).should be_a_new(A)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        A.any_instance.stub(:save).and_return(false)
        post :create, :a => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested a" do
        a = A.create! valid_attributes
        # Assuming there are no other as in the database, this
        # specifies that the A created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        A.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => a.id, :a => {'these' => 'params'}
      end

      it "assigns the requested a as @a" do
        a = A.create! valid_attributes
        put :update, :id => a.id, :a => valid_attributes
        assigns(:a).should eq(a)
      end

      it "redirects to the a" do
        a = A.create! valid_attributes
        put :update, :id => a.id, :a => valid_attributes
        response.should redirect_to(a)
      end
    end

    describe "with invalid params" do
      it "assigns the a as @a" do
        a = A.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        A.any_instance.stub(:save).and_return(false)
        put :update, :id => a.id.to_s, :a => {}
        assigns(:a).should eq(a)
      end

      it "re-renders the 'edit' template" do
        a = A.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        A.any_instance.stub(:save).and_return(false)
        put :update, :id => a.id.to_s, :a => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested a" do
      a = A.create! valid_attributes
      expect {
        delete :destroy, :id => a.id.to_s
      }.to change(A, :count).by(-1)
    end

    it "redirects to the as list" do
      a = A.create! valid_attributes
      delete :destroy, :id => a.id.to_s
      response.should redirect_to(as_url)
    end
  end

end
