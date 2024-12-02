class Plant < ApplicationRecord
    belongs_to :hectare
    has_many :boxes

    validate :max_plants_in_hectare

    def self.ransackable_attributes(auth_object = nil)
      ["column", "created_at", "growthMm", "heatJoules", "hectare_id", "humidity", "id", "oxygenationLevel", "pestPresence", "row", "steamThicknessMm", "texture", "updated_at"]
    end

  private

  def max_plants_in_hectare
    if Plant.where(hectare_id: self.hectare_id).count >= 25
      errors.add(:base, "Una hectárea no puede tener más de 25 plantas")
    end
  end

end
