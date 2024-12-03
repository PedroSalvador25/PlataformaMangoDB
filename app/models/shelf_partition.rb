class ShelfPartition < ApplicationRecord
  belongs_to :shelf
  belongs_to :box, optional: true
  
  validates :box_id, uniqueness: true, allow_nil: true
  validates :division, :partition, presence: true
  
end
