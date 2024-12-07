class PlantsDatabaseService
    def self.save_plant(plant)
      ActiveRecord::Base.transaction do
        plant.save!
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  
    def self.update_plant(plant, attributes)
      ActiveRecord::Base.transaction do
        plant.update!(attributes)
      end
    rescue ActiveRecord::RecordInvalid
      false
    end
  
    def self.delete_plant(plant)
      ActiveRecord::Base.transaction do
        plant.destroy!
      end
    rescue ActiveRecord::RecordNotDestroyed
      false
    end
  end
  