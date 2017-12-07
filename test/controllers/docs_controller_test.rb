require 'test_helper'

class DocsControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get docs_about_url
    assert_response :success
  end

  test "should get privacy-policy" do
    get docs_privacy-policy_url
    assert_response :success
  end

  test "should get user-agreement" do
    get docs_user-agreement_url
    assert_response :success
  end

end
