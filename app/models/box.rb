class Box < ApplicationRecord
    belongs_to :plant

    def self.ransackable_associations(auth_object = nil)
      ["hectare"]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "hectare_id", "quality", "weigth", "updated_at"]
      end
end
