require "test_helper"

class ShelvesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shelf = shelves(:one)
  end

  test "should get index" do
    get shelves_url
    assert_response :success
  end

  test "should get new" do
    get new_shelf_url
    assert_response :success
  end

  test "should create shelf" do
    assert_difference("Shelf.count") do
      post shelves_url, params: { shelf: { boxId: @shelf.boxId, division: @shelf.division, partition: @shelf.partition, werehouseId: @shelf.werehouseId } }
    end

    assert_redirected_to shelf_url(Shelf.last)
  end

  test "should show shelf" do
    get shelf_url(@shelf)
    assert_response :success
  end

  test "should get edit" do
    get edit_shelf_url(@shelf)
    assert_response :success
  end

  test "should update shelf" do
    patch shelf_url(@shelf), params: { shelf: { boxId: @shelf.boxId, division: @shelf.division, partition: @shelf.partition, werehouseId: @shelf.werehouseId } }
    assert_redirected_to shelf_url(@shelf)
  end

  test "should destroy shelf" do
    assert_difference("Shelf.count", -1) do
      delete shelf_url(@shelf)
    end

    assert_redirected_to shelves_url
  end
end
