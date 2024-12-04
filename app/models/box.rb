class Box < ApplicationRecord
  belongs_to :plant
  belongs_to :shelf_partition, optional: true

  delegate :hectare, to: :plant
  delegate :shelf, to: :shelf_partition

  validates :quality, presence: true
  validates :weigth, presence: true, numericality: { greater_than: 0 }

  def self.ransackable_associations(auth_object = nil)
    ["plant", "shelf_partition"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "quality", "weigth", "updated_at", "plant.hectare_id"]
  end

  def self.search(params, current_user)
    query = ransack(params)
    query.quality_eq ||= 'quality' if current_user.role == 'WarehouseManager'
    query
  end

  def self.fetch_hectares_for_combo
    BoxesDatabaseService.fetch_hectares_for_combo
  end

  def self.create_box(params)
    BoxesDatabaseService.create_box(params)
  end

  def self.update_box(id, params)
    BoxesDatabaseService.update_box(id, params)
  end

  def self.destroy_box(id)
    BoxesDatabaseService.destroy_box(id)
  end

  def release_kilos(kilos_to_release)
    BoxesDatabaseService.release_kilos(self, kilos_to_release)
  end
end

