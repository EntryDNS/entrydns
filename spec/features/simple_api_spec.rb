require 'spec_helper'

feature "devise" do
  include_context "data"

  scenario "modify record" do
    visit modify_record_path(:authentication_token => a_record.authentication_token)
    expect(page).to have_content Users::RecordsController::MODIFY_OK
  end
end
