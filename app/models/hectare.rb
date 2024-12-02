class Hectare < ApplicationRecord
    has_many :plants
    def self.ransackable_attributes(auth_object = nil)
        [ "community", "created_at", "id", "latitude", "longitude", "updated_at" ]
      end

    def check_hectare(id)
        HarvestAuthorizationService.ready(id)
    end

    def authorize!
        update(isAuthorized: true)
      end
end
