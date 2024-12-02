class Box < ApplicationRecord
  belongs_to :plant
  delegate :hectare, to: :plant

  def self.ransackable_associations(auth_object = nil)
    ["plant"] 
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "quality", "weigth", "updated_at", "plant.hectare_id"]
  end
end
