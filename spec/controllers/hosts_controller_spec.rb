require 'spec_helper'

describe HostsController do
  it_should_behave_like "wiring controller"
end

# TODO implement me
__END__

  # This should return the minimal set of attributes required to create a valid
  # Host. As you add validations to Host, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all hosts as @hosts" do
      host = Host.create! valid_attributes
      get :index
      assigns(:hosts).should eq([host])
    end
  end

  describe "GET show" do
    it "assigns the requested host as @host" do
      host = Host.create! valid_attributes
      get :show, :id => host.id.to_s
      assigns(:host).should eq(host)
    end
  end

  describe "GET new" do
    it "assigns a new host as @host" do
      get :new
      assigns(:host).should be_a_new(Host)
    end
  end

  describe "GET edit" do
    it "assigns the requested host as @host" do
      host = Host.create! valid_attributes
      get :edit, :id => host.id.to_s
      assigns(:host).should eq(host)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Host" do
        expect {
          post :create, :host => valid_attributes
        }.to change(Host, :count).by(1)
      end

      it "assigns a newly created host as @host" do
        post :create, :host => valid_attributes
        assigns(:host).should be_a(Host)
        assigns(:host).should be_persisted
      end

      it "redirects to the created host" do
        post :create, :host => valid_attributes
        response.should redirect_to(Host.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved host as @host" do
        # Trigger the behavior that occurs when invalid params are submitted
        Host.any_instance.stub(:save).and_return(false)
        post :create, :host => {}
        assigns(:host).should be_a_new(Host)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Host.any_instance.stub(:save).and_return(false)
        post :create, :host => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested host" do
        host = Host.create! valid_attributes
        # Assuming there are no other hosts in the database, this
        # specifies that the Host created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Host.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => host.id, :host => {'these' => 'params'}
      end

      it "assigns the requested host as @host" do
        host = Host.create! valid_attributes
        put :update, :id => host.id, :host => valid_attributes
        assigns(:host).should eq(host)
      end

      it "redirects to the host" do
        host = Host.create! valid_attributes
        put :update, :id => host.id, :host => valid_attributes
        response.should redirect_to(host)
      end
    end

    describe "with invalid params" do
      it "assigns the host as @host" do
        host = Host.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Host.any_instance.stub(:save).and_return(false)
        put :update, :id => host.id.to_s, :host => {}
        assigns(:host).should eq(host)
      end

      it "re-renders the 'edit' template" do
        host = Host.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Host.any_instance.stub(:save).and_return(false)
        put :update, :id => host.id.to_s, :host => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested host" do
      host = Host.create! valid_attributes
      expect {
        delete :destroy, :id => host.id.to_s
      }.to change(Host, :count).by(-1)
    end

    it "redirects to the hosts list" do
      host = Host.create! valid_attributes
      delete :destroy, :id => host.id.to_s
      response.should redirect_to(hosts_url)
    end
  end

end
