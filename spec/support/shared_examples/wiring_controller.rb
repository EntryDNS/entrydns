shared_examples_for "wiring controller" do
  context "wiring" do
    include_context "data"
    let(:record){Record.new}

    context "on owned domain" do
      before do
        sign_in user
        @controller.stub(:nested_parent_record => domain)
      end

      it "#new_model is wired" do
        @controller.send(:new_model).user.should == domain.user
      end

      it "#before_create_save wires" do
        @controller.send(:before_create_save, record)
        record.user.should == domain.user
      end
    end

    context "on permitted domain" do
      before do
        sign_in user2
        permission # touch to ensure creation
        @controller.stub(:nested_parent_record => domain)
      end

      it "#new_model is wired" do
        @controller.send(:new_model).user.should == domain.user
      end

      it "#before_create_save wires" do
        @controller.send(:before_create_save, record)
        record.user.should == domain.user
      end
    end

  end
end
