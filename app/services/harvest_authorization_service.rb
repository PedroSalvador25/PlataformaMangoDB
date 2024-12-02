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
              humidity_ok: plant.humidity.between?(40.0, 70.0),         
              growth_ok: plant.growthMm >= 150.0,                      
              heat_ok: plant.heatJoules.between?(1000.0, 2500.0),      
              steam_ok: plant.steamThicknessMm >= 20.0,                
              pest_free: !plant.pestPresence,                          
              texture_ok: [ "firm", "mature", "ripe" ].include?(plant.texture.downcase), 
              oxygenation_ok: plant.oxygenationLevel >= 80.0          
            }
        end
        total_plants = plants.count
        plants_all_ok = plants_status.count { |status| status.values.all? }
        percentage_ok = (plants_all_ok.to_f / total_plants) * 100

        # Return true if more than 80% of the plants are okay, otherwise false
        percentage_ok >= 80.0
    end
end
