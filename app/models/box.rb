class Box < ApplicationRecord
  belongs_to :plant
  belongs_to :shelf_partition, optional: true
  belongs_to :shelf, optional: true

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

  def assign_to_shelf_partition(shelf_partition)
    update(shelf_partition: shelf_partition)
  end

  def unassign_from_shelf_partition
    update(shelf_partition: nil)
  end
end