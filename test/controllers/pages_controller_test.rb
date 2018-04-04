require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get pages_home_url
    assert_response :success
  end

  test "should get matchup" do
    get pages_matchup_url
    assert_response :success
  end

  test "should get trades" do
    get pages_trades_url
    assert_response :success
  end

end
