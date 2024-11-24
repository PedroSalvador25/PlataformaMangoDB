require "application_system_test_case"

class HectaresTest < ApplicationSystemTestCase
  setup do
    @hectare = hectares(:one)
  end

  test "visiting the index" do
    visit hectares_url
    assert_selector "h1", text: "Hectares"
  end

  test "should create hectare" do
    visit hectares_url
    click_on "New hectare"

    fill_in "Community", with: @hectare.community
    fill_in "Latitude", with: @hectare.latitude
    fill_in "Longitude", with: @hectare.longitude
    click_on "Create Hectare"

    assert_text "Hectare was successfully created"
    click_on "Back"
  end

  test "should update Hectare" do
    visit hectare_url(@hectare)
    click_on "Edit this hectare", match: :first

    fill_in "Community", with: @hectare.community
    fill_in "Latitude", with: @hectare.latitude
    fill_in "Longitude", with: @hectare.longitude
    click_on "Update Hectare"

    assert_text "Hectare was successfully updated"
    click_on "Back"
  end

  test "should destroy Hectare" do
    visit hectare_url(@hectare)
    click_on "Destroy this hectare", match: :first

    assert_text "Hectare was successfully destroyed"
  end
end
