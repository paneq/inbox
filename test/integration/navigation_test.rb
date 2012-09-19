require 'test_helper'

class NavigationTest < Bbq::TestCase
  setup do
    @user  = Bbq::TestUser.new
    @email = "robert.pankowecki@gmail.com"
    # TODO: Set :test delivery method here
  end

  test "casual plaintext email" do
    @user.visit "/inbox/#{@email}/emails/new"
    @user.fill_in "email[from]",    with: @email
    @user.fill_in "email[to]",      with: @email
    @user.fill_in "email[subject]", with: "Hello"
    @user.fill_in "email[body]",    with: "How are you"
    @user.click_on "Create Email"

    @user.visit "/inbox/#{@email}/emails/new"
    assert @user.see? "Hello"
    @user.click_on "Hello"
    assert @user.see? "How are you"
  end

end

