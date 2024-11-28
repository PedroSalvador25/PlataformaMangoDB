class Hectare < ApplicationRecord
    has_many :boxes
    has_many :plants
    
    def self.ransackable_attributes(auth_object = nil)
        ["community", "created_at", "id", "latitude", "longitude", "updated_at"]
      end

    def harvest_authorized?
        HarvestAuthorizationService.new(self).authorized?
    end
end
