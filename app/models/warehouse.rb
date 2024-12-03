class Warehouse < ApplicationRecord
  has_many :shelves, dependent: :destroy

  validates :name, :location, :warehouse_type, presence: true
  validates :warehouse_type, inclusion: { in: ['calidad', 'no calidad'] }

  scope :high_quality, -> { where(warehouse_type: 'calidad') }
  scope :low_quality, -> { where(warehouse_type: 'no calidad') }

  after_create :create_shelves

  attr_accessor :input_pointer, :output_pointer

  after_initialize :initialize_pointers

  def initialize_pointers
    self.input_pointer ||= 0
    self.output_pointer ||= 0
  end

  def total_shelf_partitions
    shelves.joins(:shelf_partitions).count
  end

  def increment_input_pointer
    self.input_pointer = (self.input_pointer + 1) % total_shelf_partitions
  end

  def increment_output_pointer
    update!(output_pointer: (output_pointer + 1) % shelf_partitions.count)
  end
  
  private

  def create_shelves
    10.times do
      shelves.create!
    end
  end
end
