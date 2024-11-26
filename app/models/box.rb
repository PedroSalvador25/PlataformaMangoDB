class Box < ApplicationRecord
    belongs_to :hectare

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "hectare", "quality", "weigth", "updated_at"]
      end
end
