require "application_system_test_case"

class BoxesTest < ApplicationSystemTestCase
  setup do
    @box = boxes(:one)
  end

  test "visiting the index" do
    visit boxes_url
    assert_selector "h1", text: "Boxes"
  end

  test "should create box" do
    visit boxes_url
    click_on "New box"

    fill_in "Hectare", with: @box.hectare
    fill_in "Name", with: @box.name
    fill_in "Quality", with: @box.quality
    fill_in "Weigth", with: @box.weigth
    click_on "Create Box"

    assert_text "Box was successfully created"
    click_on "Back"
  end

  test "should update Box" do
    visit box_url(@box)
    click_on "Edit this box", match: :first

    fill_in "Hectare", with: @box.hectare
    fill_in "Name", with: @box.name
    fill_in "Quality", with: @box.quality
    fill_in "Weigth", with: @box.weigth
    click_on "Update Box"

    assert_text "Box was successfully updated"
    click_on "Back"
  end

  test "should destroy Box" do
    visit box_url(@box)
    click_on "Destroy this box", match: :first

    assert_text "Box was successfully destroyed"
  end
end
