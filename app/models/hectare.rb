class Hectare < ApplicationRecord

    def harvest_authorized?
        HarvestAuthorizationService.new(self).authorized?
    end
end
