class HarvestAuthorizationService
    def self.ready(hectare_id)
        # list of all the plants in the hectare
        plants = Plant.where(hectare_id: hectare_id)
        return false if plants.empty?
        check_all_parameters(plants)
    end

    def self.check_all_parameters(plants)
        plants_status = plants.map do |plant|
            {
              humidity_ok: check_humidity(plant),
              growth_ok: check_growth(plant),
              heat_ok: check_heat(plant),
              steam_ok: check_steam_thickness(plant),
              pest_free: !check_pest(plant),
              texture_ok: check_texture(plant),
              oxygenation_ok: check_oxygenation(plant)
            }
          end
        total_plants = plants.count
        plants_all_ok = plants_status.count { |status| status.values.all? }
        percentage_ok = (plants_all_ok.to_f / total_plants) * 100

        # Return true if more than 80% of the plants are okay, otherwise false
        percentage_ok > 80
    end

    def self.check_humidity(plant)
        # in %
        plant.humidity.between?(40.0, 70.0)
    end

    def self.check_growth(plant)
        # in millimeters
        plant.growthMm >= 150.0
    end

    def self.check_heat(plant)
        # in joules
        plant.heatJoules.between?(1000.0, 2500.0)
      end

    def self.check_steam_thickness(plant)
        # in millimeters
        plant.steamThicknessMm >= 20.0
    end

    def self.check_pest(plant)
        # Acceptable textures
        plant.pestPresence
    end

    def self.check_texture(plant)
        # Acceptable textures
        [ "firm", "mature", "ripe" ].include?(plant.texture.downcase)
      end

    def self.check_oxygenation(plant)
        # in %
        plant.oxygenationLevel >= 80.0
    end
end
