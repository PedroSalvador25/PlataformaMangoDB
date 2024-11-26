class Hectare < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["community", "created_at", "id", "latitude", "longitude", "updated_at"]
      end

    def harvest_authorized?
        HarvestAuthorizationService.new(self).authorized?
    end
end
