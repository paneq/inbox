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

    @user.visit "/inbox/#{@email}/emails"
    assert @user.see? "Hello"
    @user.click_on "Hello"
    assert @user.see? "How are you"
  end

  test "rich html email has one body only" do
    @user.visit "/inbox/examples/rich_html"
    @user.visit "/inbox/example@example.org/emails/new"
    @user.click_on "Rich html"
    assert_equal 1, @user.page.driver.source.split.select{|line| line.downcase.include?("<html") }.size
    # @user.page.all(:xpath, "//body").size - nokogiri ignores invalid html inside html
    # Anything that goes through nokogiri will not properly check lik3
    # @user.page.html etc...
  end

  test "and html and text" do
    @user.visit "/inbox/examples/html_plus_text"
    @user.visit "/inbox/example@example.org/emails"

    @user.click_on "Html plus text"
    assert @user.see? "This is text with link"
    assert @user.find(".the-link").find_link("Arkency")

    @user.click_on "View plain text version"
    assert @user.see? "This is text with link :"
    assert @user.find("#message_body").find_link("http://arkency.com")
  end

  test "html can be seen multiple times" do
    @user.visit "/inbox/examples/html_real_body"
    @user.visit "/inbox/example@example.org/emails"

    @user.click_on "Html real body"
    assert @user.see? "Inside body"

    @user.click_on "Html real body"
    assert @user.see? "Inside body"
  end

end

