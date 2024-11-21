require "test_helper"

class HectaresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hectare = hectares(:one)
  end

  test "should get index" do
    get hectares_url
    assert_response :success
  end

  test "should get new" do
    get new_hectare_url
    assert_response :success
  end

  test "should create hectare" do
    assert_difference("Hectare.count") do
      post hectares_url, params: { hectare: { community: @hectare.community, latitude: @hectare.latitude, longitude: @hectare.longitude } }
    end

    assert_redirected_to hectare_url(Hectare.last)
  end

  test "should show hectare" do
    get hectare_url(@hectare)
    assert_response :success
  end

  test "should get edit" do
    get edit_hectare_url(@hectare)
    assert_response :success
  end

  test "should update hectare" do
    patch hectare_url(@hectare), params: { hectare: { community: @hectare.community, latitude: @hectare.latitude, longitude: @hectare.longitude } }
    assert_redirected_to hectare_url(@hectare)
  end

  test "should destroy hectare" do
    assert_difference("Hectare.count", -1) do
      delete hectare_url(@hectare)
    end

    assert_redirected_to hectares_url
  end
end
