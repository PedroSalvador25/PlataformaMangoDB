class Warehouse < ApplicationRecord
  has_many :shelves, dependent: :destroy

  validates :name, :location, :warehouse_type, presence: true
  validates :warehouse_type, inclusion: { in: ['calidad', 'no calidad'] }

  scope :high_quality, -> { WarehousesDatabaseService.high_quality }
  scope :low_quality, -> { WarehousesDatabaseService.low_quality }

  attr_accessor :input_pointer, :output_pointer

  after_initialize :initialize_pointers
  after_create :create_shelves

  def initialize_pointers
    self.input_pointer ||= 0
    self.output_pointer ||= 0
  end

  def total_shelf_partitions
    WarehousesDatabaseService.total_shelf_partitions(self.id)
  end

  def increment_input_pointer
    self.input_pointer = (self.input_pointer + 1) % total_shelf_partitions
  end

  def increment_output_pointer
    self.output_pointer = (self.output_pointer + 1) % total_shelf_partitions
    WarehousesDatabaseService.update_output_pointer(self.id, output_pointer)
  end

  def save_record
    WarehousesDatabaseService.save_warehouse(self)
  end

  def update_record(attributes)
    WarehousesDatabaseService.update_warehouse(self, attributes)
  end

  def delete_record
    WarehousesDatabaseService.delete_warehouse(self)
  end

  private

  def create_shelves
    WarehousesDatabaseService.create_shelves(self.id)
  end
end

