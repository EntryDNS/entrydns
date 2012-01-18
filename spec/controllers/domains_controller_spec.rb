require 'spec_helper'

describe DomainsController do
  
  context "wiring" do
    include_context "data"
    
    # a domain who's parent domain is not in our system
    context "domain" do
      before do
        sign_in user
      end

      it "is wired with the current user by #new_model" do
        @controller.send(:new_model).user.should == user
      end
    
      it "is wired with the current user by #before_create_save" do
        domain = build(:domain)
        @controller.send(:before_create_save, domain)
        domain.user.should == user
      end
    end
    
    # a domain who's parent domain is in our system
    context "subdomain" do
      before do
        sign_in user2
      end
      
      it "is wired with the user of the parent domain by #before_create_save" do
        subdomain = build(:domain, :user => user2, :name => "x.#{domain.name}")
        @controller.send(:before_create_save, subdomain)
        subdomain.user.should == user
      end
    end
    
  end
end

# TODO implement me
__END__
  
# This should return the minimal set of attributes required to create a valid
# Domain. As you add validations to Domain, be sure to
# update the return value of this method accordingly.
def valid_attributes
  {}
end

describe "GET index" do
  it "assigns all domains as @domains" do
    domain = Domain.create! valid_attributes
    get :index
    assigns(:domains).should eq([domain])
  end
end

describe "GET show" do
  it "assigns the requested domain as @domain" do
    domain = Domain.create! valid_attributes
    get :show, :id => domain.id.to_s
    assigns(:domain).should eq(domain)
  end
end

describe "GET new" do
  it "assigns a new domain as @domain" do
    get :new
    assigns(:domain).should be_a_new(Domain)
  end
end

describe "GET edit" do
  it "assigns the requested domain as @domain" do
    domain = Domain.create! valid_attributes
    get :edit, :id => domain.id.to_s
    assigns(:domain).should eq(domain)
  end
end

describe "POST create" do
  describe "with valid params" do
    it "creates a new Domain" do
      expect {
        post :create, :domain => valid_attributes
      }.to change(Domain, :count).by(1)
    end

    it "assigns a newly created domain as @domain" do
      post :create, :domain => valid_attributes
      assigns(:domain).should be_a(Domain)
      assigns(:domain).should be_persisted
    end

    it "redirects to the created domain" do
      post :create, :domain => valid_attributes
      response.should redirect_to(Domain.last)
    end
  end

  describe "with invalid params" do
    it "assigns a newly created but unsaved domain as @domain" do
      # Trigger the behavior that occurs when invalid params are submitted
      Domain.any_instance.stub(:save).and_return(false)
      post :create, :domain => {}
      assigns(:domain).should be_a_new(Domain)
    end

    it "re-renders the 'new' template" do
      # Trigger the behavior that occurs when invalid params are submitted
      Domain.any_instance.stub(:save).and_return(false)
      post :create, :domain => {}
      response.should render_template("new")
    end
  end
end

describe "PUT update" do
  describe "with valid params" do
    it "updates the requested domain" do
      domain = Domain.create! valid_attributes
      # Assuming there are no other domains in the database, this
      # specifies that the Domain created on the previous line
      # receives the :update_attributes message with whatever params are
      # submitted in the request.
      Domain.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
      put :update, :id => domain.id, :domain => {'these' => 'params'}
    end

    it "assigns the requested domain as @domain" do
      domain = Domain.create! valid_attributes
      put :update, :id => domain.id, :domain => valid_attributes
      assigns(:domain).should eq(domain)
    end

    it "redirects to the domain" do
      domain = Domain.create! valid_attributes
      put :update, :id => domain.id, :domain => valid_attributes
      response.should redirect_to(domain)
    end
  end

  describe "with invalid params" do
    it "assigns the domain as @domain" do
      domain = Domain.create! valid_attributes
      # Trigger the behavior that occurs when invalid params are submitted
      Domain.any_instance.stub(:save).and_return(false)
      put :update, :id => domain.id.to_s, :domain => {}
      assigns(:domain).should eq(domain)
    end

    it "re-renders the 'edit' template" do
      domain = Domain.create! valid_attributes
      # Trigger the behavior that occurs when invalid params are submitted
      Domain.any_instance.stub(:save).and_return(false)
      put :update, :id => domain.id.to_s, :domain => {}
      response.should render_template("edit")
    end
  end
end

describe "DELETE destroy" do
  it "destroys the requested domain" do
    domain = Domain.create! valid_attributes
    expect {
      delete :destroy, :id => domain.id.to_s
    }.to change(Domain, :count).by(-1)
  end

  it "redirects to the domains list" do
    domain = Domain.create! valid_attributes
    delete :destroy, :id => domain.id.to_s
    response.should redirect_to(domains_url)
  end
end

end