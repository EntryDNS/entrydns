require 'spec_helper'

describe RecordsController do
  
  describe "PUT modify" do
    include_context "data"
    
    before do
      sign_in user
      controller.stub(:current_user).and_return(user)
    end
    
    it "modifies @record when IP given" do
      ip = '127.0.0.2'
      put :modify, :authentication_token => a_record.authentication_token, :ip => ip
      response.should be_success
      response.body.should == RecordsController::MODIFY_OK
      assigns(:record).should == a_record
      assigns(:record).content.should == ip
    end
    
    it "modifies @record with remote IP" do
      ip = '127.0.0.3'
      request.env["HTTP_X_FORWARDED_FOR"] = ip
      put :modify, :authentication_token => a_record.authentication_token
      response.should be_success
      response.body.should == RecordsController::MODIFY_OK
      assigns(:record).should == a_record
      assigns(:record).content.should == ip
    end

    it "errors when not A type @record with" do
      ip = '127.0.0.3'
      request.env["HTTP_X_FORWARDED_FOR"] = ip
      put :modify, :authentication_token => soa_record.authentication_token
      response.should be_success
      response.body.should == RecordsController::MODIFY_ERROR
    end
    
  end

end

# TODO implement me
__END__
  
  # This should return the minimal set of attributes required to create a valid
  # Record. As you add validations to Record, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all records as @records" do
      record = Record.create! valid_attributes
      get :index
      assigns(:records).should eq([record])
    end
  end

  describe "GET show" do
    it "assigns the requested record as @record" do
      record = Record.create! valid_attributes
      get :show, :id => record.id.to_s
      assigns(:record).should eq(record)
    end
  end

  describe "GET new" do
    it "assigns a new record as @record" do
      get :new
      assigns(:record).should be_a_new(Record)
    end
  end

  describe "GET edit" do
    it "assigns the requested record as @record" do
      record = Record.create! valid_attributes
      get :edit, :id => record.id.to_s
      assigns(:record).should eq(record)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Record" do
        expect {
          post :create, :record => valid_attributes
        }.to change(Record, :count).by(1)
      end

      it "assigns a newly created record as @record" do
        post :create, :record => valid_attributes
        assigns(:record).should be_a(Record)
        assigns(:record).should be_persisted
      end

      it "redirects to the created record" do
        post :create, :record => valid_attributes
        response.should redirect_to(Record.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved record as @record" do
        # Trigger the behavior that occurs when invalid params are submitted
        Record.any_instance.stub(:save).and_return(false)
        post :create, :record => {}
        assigns(:record).should be_a_new(Record)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Record.any_instance.stub(:save).and_return(false)
        post :create, :record => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested record" do
        record = Record.create! valid_attributes
        # Assuming there are no other records in the database, this
        # specifies that the Record created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Record.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => record.id, :record => {'these' => 'params'}
      end

      it "assigns the requested record as @record" do
        record = Record.create! valid_attributes
        put :update, :id => record.id, :record => valid_attributes
        assigns(:record).should eq(record)
      end

      it "redirects to the record" do
        record = Record.create! valid_attributes
        put :update, :id => record.id, :record => valid_attributes
        response.should redirect_to(record)
      end
    end

    describe "with invalid params" do
      it "assigns the record as @record" do
        record = Record.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Record.any_instance.stub(:save).and_return(false)
        put :update, :id => record.id.to_s, :record => {}
        assigns(:record).should eq(record)
      end

      it "re-renders the 'edit' template" do
        record = Record.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Record.any_instance.stub(:save).and_return(false)
        put :update, :id => record.id.to_s, :record => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested record" do
      record = Record.create! valid_attributes
      expect {
        delete :destroy, :id => record.id.to_s
      }.to change(Record, :count).by(-1)
    end

    it "redirects to the records list" do
      record = Record.create! valid_attributes
      delete :destroy, :id => record.id.to_s
      response.should redirect_to(records_url)
    end
  end

end
