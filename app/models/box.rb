class Box < ApplicationRecord
  belongs_to :plant
  delegate :hectare, to: :plant
  belongs_to :shelf, optional: true

  validates :quality, presence: true
  validates :weigth, presence: true, numericality: { greater_than: 0 }


  def self.ransackable_associations(auth_object = nil)
    ["plant"] 
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "quality", "weigth", "updated_at", "plant.hectare_id"]
  end
  def assign_to_shelf(shelf)
    update(shelf: shelf, occupied: true)
  end
  
  def unassign_from_shelf
    update(shelf: nil, occupied: false)
  end
end
