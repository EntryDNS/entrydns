require 'spec_helper'

describe Users::RecordsController do
  it_should_behave_like "wiring controller"

  describe "GET modify" do
    include_context "data"

    before do
      sign_in user
    end

    it "modifies @record when IP given" do
      ip = '127.0.0.2'
      get :modify, :authentication_token => a_record.authentication_token, :ip => ip
      response.should be_success
      response.body.should == Users::RecordsController::MODIFY_OK
      assigns(:record).should == a_record
      assigns(:record).content.should == ip
    end

    it "modifies @record with remote IP" do
      ip = '127.0.0.3'
      @request.env['REMOTE_ADDR'] = ip
      get :modify, :authentication_token => a_record.authentication_token
      response.should be_success
      response.body.should == Users::RecordsController::MODIFY_OK
      assigns(:record).should == a_record
      assigns(:record).content.should == ip
    end

    it "errors when not A type @record with" do
      ip = '127.0.0.3'
      @request.env['REMOTE_ADDR'] = ip
      get :modify, :authentication_token => soa_record.authentication_token
      response.should be_success
      response.body.should == Users::RecordsController::MODIFY_ERROR
    end

  end

end
