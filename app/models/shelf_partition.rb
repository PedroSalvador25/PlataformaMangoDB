class ShelfPartition < ApplicationRecord
  belongs_to :shelf
  validates :division, :partition, presence: true
end
