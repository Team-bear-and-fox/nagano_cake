require "test_helper"

class OredersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get oreders_show_url
    assert_response :success
  end
end
