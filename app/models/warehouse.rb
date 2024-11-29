class Warehouse < ApplicationRecord
    has_many :shelves
    validates :name, presence: true
    validates :location, presence: true
    validates :quality_type, presence: true, inclusion: { in: ['high', 'low'] }
    
    scope :high_quality, -> { where(quality_type: 'calidad') }
    scope :low_quality, -> { where(quality_type: 'no calidad') }
  end