class Warehouse < ApplicationRecord
  has_many :shelves, dependent: :destroy
  validates :name, :location, :warehouse_type, presence: true
  validates :warehouse_type, inclusion: { in: ['calidad', 'no calidad'] }

  scope :high_quality, -> { where(warehouse_type: 'calidad') }
  scope :low_quality, -> { where(warehouse_type: 'no calidad') }

  after_create :create_shelves

  private

  def create_shelves
    (1..10).each do |_|
      self.shelves.create!(warehouse_id: self.id)
    end
  end
end
