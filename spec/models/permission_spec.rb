require 'spec_helper'

describe Permission do
  include_context "data"

  it "validates selfness" do
    permission.user_id = permission.domain.user_id
    permission.should have(1).error_on(:user)
  end

  it "validates unexsisting email" do
    permission.user_email = "does.not@exist.in.db"
    permission.should have(1).error_on(:user)
  end
end
