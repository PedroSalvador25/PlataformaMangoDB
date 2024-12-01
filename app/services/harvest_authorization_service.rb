class HarvestAuthorizationService
    def self.authorized?
        hectare_id=
        # list of all the plants in the hectare x
        @plants = Plant.where(hectare_id: params[:hectare_id])
        return false if @plants.empty?
        check_all_parameters
    end

    def check_all_parameters
        plants_status = @plants.map do |plant|
            {
              humidity_ok: check_humidity(plant),
              growth_ok: check_growth(plant),
              heat_ok: check_heat(plant),
              stem_ok: check_stem_thickness(plant),
              pest_free: !plant.pest_presence,
              texture_ok: check_texture(plant),
              oxygenation_ok: check_oxygenation(plant)
            }
          end
        total_plants = @plants.count
        plants_all_ok = plants_status.count { |status| status.values.all? }
        percentage_ok = (plants_all_ok.to_f / total_plants) * 100

        # Return true if more than 80% of the plants are okay, otherwise false
        percentage_ok > 80
    end

    def check_humidity(plant)
        # in %
        plant.humidity.between?(40.0, 70.0)
    end

    def check_growth(plant)
        # in millimeters
        plant.growthMm >= 150.0
    end

    def check_heat(plant)
        # in joules
        plant.heatJoules.between?(1000.0, 2500.0)
      end

    def check_stem_thickness(plant)
        # in millimeters
        plant.stemThicknessMm >= 20.0
    end

    def check_pest(plant)
        # Acceptable textures
        !plant.pestPresence
    end

    def check_texture(plant)
        # Acceptable textures
        [ "firm", "mature", "ripe" ].include?(plant.texture.downcase)
      end

    def check_oxygenation(plant)
        # in %
        plant.oxygenationLevel >= 80.0
    end
end
