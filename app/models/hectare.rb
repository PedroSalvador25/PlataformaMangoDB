class Hectare < ApplicationRecord
    has_many :plants
    def self.ransackable_attributes(auth_object = nil)
        [ "community", "created_at", "id", "latitude", "longitude", "updated_at" ]
      end

    def check_hectare?
        self.authorized = HarvestAuthorizationService.authorized?
    end
end
