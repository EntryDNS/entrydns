require 'spec_helper'

feature "devise" do
  include_context "data"
  let(:new_user) { build(:user) }

  def sign_up_user
    visit new_user_registration_path
    within('#new_user') do
      fill_in 'Full name', with: new_user.full_name
      fill_in 'Email', with: new_user.email
      fill_in 'Password', with: new_user.password
      click_link_or_button 'Sign up'
    end
  end

  scenario "sign up" do
    sign_up_user

    # was success
    current_path.should == page_path('notice')
    expect(page).to have_content I18n.t('devise.registrations.signed_up_but_unconfirmed')

    # sent mail
    assert_equal [new_user.email], ActionMailer::Base.deliveries.last.to

    # saved user
    user = User.order(:id).last
    assert_equal user.email, new_user.email
  end

  scenario "sign in" do
    user

    visit new_user_session_path
    within('#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_link_or_button 'Sign in'
    end

    # was success
    current_path.should == domains_path
    find('.navbar-main').should have_content user.email

    # sent mail
    assert_equal [user.email], ActionMailer::Base.deliveries.last.to
  end

  let(:friendly_token) { 'abcdef' }

  def forgot_password
    Devise.stub(:friendly_token).and_return(friendly_token)
    visit new_user_password_path
    within('#new_user') do
      fill_in 'Email', with: user.email
      click_link_or_button 'Send reset password instructions'
    end
  end

  scenario "forgot password" do
    user

    forgot_password

    # was success
    current_path.should == new_user_session_path
    expect(page).to have_content I18n.t('devise.passwords.send_instructions')
  end

  scenario "reset password" do
    user

    forgot_password
    visit edit_user_password_path(:reset_password_token => friendly_token)
    within('#new_user') do
      fill_in 'New password', with: '9876543210'
      fill_in 'Confirm new password', with: '9876543210'
      click_button 'Change my password'
    end
    sleep 10
    # was success
    current_path.should == domains_path
    expect(page).to have_content I18n.t('devise.passwords.updated')
  end

end
