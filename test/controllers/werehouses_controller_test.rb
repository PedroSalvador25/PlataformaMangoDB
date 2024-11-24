require "test_helper"

class WerehousesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @werehouse = werehouses(:one)
  end

  test "should get index" do
    get werehouses_url
    assert_response :success
  end

  test "should get new" do
    get new_werehouse_url
    assert_response :success
  end

  test "should create werehouse" do
    assert_difference("Werehouse.count") do
      post werehouses_url, params: { werehouse: { location: @werehouse.location, name: @werehouse.name } }
    end

    assert_redirected_to werehouse_url(Werehouse.last)
  end

  test "should show werehouse" do
    get werehouse_url(@werehouse)
    assert_response :success
  end

  test "should get edit" do
    get edit_werehouse_url(@werehouse)
    assert_response :success
  end

  test "should update werehouse" do
    patch werehouse_url(@werehouse), params: { werehouse: { location: @werehouse.location, name: @werehouse.name } }
    assert_redirected_to werehouse_url(@werehouse)
  end

  test "should destroy werehouse" do
    assert_difference("Werehouse.count", -1) do
      delete werehouse_url(@werehouse)
    end

    assert_redirected_to werehouses_url
  end
end
