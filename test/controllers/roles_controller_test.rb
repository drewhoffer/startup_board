require "test_helper"

class RolesControllerTest < ActionDispatch::IntegrationTest
  test "should get confirm_applicant" do
    get roles_confirm_applicant_url
    assert_response :success
  end
end
