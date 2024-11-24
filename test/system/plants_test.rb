require "application_system_test_case"

class PlantsTest < ApplicationSystemTestCase
  setup do
    @plant = plants(:one)
  end

  test "visiting the index" do
    visit plants_url
    assert_selector "h1", text: "Plants"
  end

  test "should create plant" do
    visit plants_url
    click_on "New plant"

    fill_in "Hectareid", with: @plant.HectareId
    fill_in "Growthmm", with: @plant.growthMm
    fill_in "Heatjoules", with: @plant.heatJoules
    fill_in "Humidity", with: @plant.humidity
    fill_in "Oxygenationlevel", with: @plant.oxygenationLevel
    check "Pestpresence" if @plant.pestPresence
    fill_in "Steamthicknessmm", with: @plant.steamThicknessMm
    fill_in "Texture", with: @plant.texture
    click_on "Create Plant"

    assert_text "Plant was successfully created"
    click_on "Back"
  end

  test "should update Plant" do
    visit plant_url(@plant)
    click_on "Edit this plant", match: :first

    fill_in "Hectareid", with: @plant.HectareId
    fill_in "Growthmm", with: @plant.growthMm
    fill_in "Heatjoules", with: @plant.heatJoules
    fill_in "Humidity", with: @plant.humidity
    fill_in "Oxygenationlevel", with: @plant.oxygenationLevel
    check "Pestpresence" if @plant.pestPresence
    fill_in "Steamthicknessmm", with: @plant.steamThicknessMm
    fill_in "Texture", with: @plant.texture
    click_on "Update Plant"

    assert_text "Plant was successfully updated"
    click_on "Back"
  end

  test "should destroy Plant" do
    visit plant_url(@plant)
    click_on "Destroy this plant", match: :first

    assert_text "Plant was successfully destroyed"
  end
end
