shared_examples_for "wiring controller" do
  context "wiring" do
    include_context "data"
  
    before do
      sign_in user
    end

    it "#new_model is wired" do
      @controller.send(:new_model).user.should == user
    end
  end
end