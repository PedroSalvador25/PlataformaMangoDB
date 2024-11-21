require "application_system_test_case"

class WerehousesTest < ApplicationSystemTestCase
  setup do
    @werehouse = werehouses(:one)
  end

  test "visiting the index" do
    visit werehouses_url
    assert_selector "h1", text: "Werehouses"
  end

  test "should create werehouse" do
    visit werehouses_url
    click_on "New werehouse"

    fill_in "Location", with: @werehouse.location
    fill_in "Name", with: @werehouse.name
    click_on "Create Werehouse"

    assert_text "Werehouse was successfully created"
    click_on "Back"
  end

  test "should update Werehouse" do
    visit werehouse_url(@werehouse)
    click_on "Edit this werehouse", match: :first

    fill_in "Location", with: @werehouse.location
    fill_in "Name", with: @werehouse.name
    click_on "Update Werehouse"

    assert_text "Werehouse was successfully updated"
    click_on "Back"
  end

  test "should destroy Werehouse" do
    visit werehouse_url(@werehouse)
    click_on "Destroy this werehouse", match: :first

    assert_text "Werehouse was successfully destroyed"
  end
end
