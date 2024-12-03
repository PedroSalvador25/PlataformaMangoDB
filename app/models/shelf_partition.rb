class ShelfPartition < ApplicationRecord
  belongs_to :shelf
  has_one :box 

  validates :division, :partition, presence: true
end
