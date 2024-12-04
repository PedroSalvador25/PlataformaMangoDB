class Plant < ApplicationRecord
  belongs_to :hectare
  has_many :boxes

  validate :max_plants_in_hectare
  validates :hectare_id, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[column created_at growthMm heatJoules hectare_id humidity id oxygenationLevel pestPresence row steamThicknessMm texture updated_at]
  end

  def save_record
    PlantsDatabaseService.save_plant(self)
  end

  def update_record(attributes)
    PlantsDatabaseService.update_plant(self, attributes)
  end

  def delete_record
    PlantsDatabaseService.delete_plant(self)
  end

  private

  def max_plants_in_hectare
    if Plant.where(hectare_id: self.hectare_id).count >= 25
      errors.add(:base, "Una hectárea no puede tener más de 25 plantas")
    end
  end
end

