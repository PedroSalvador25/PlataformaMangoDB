class Box < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "hectare", "quality", "weigth", "updated_at"]
      end
end
