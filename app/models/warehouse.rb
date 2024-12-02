class Warehouse < ApplicationRecord
  has_many :shelves
  validates :name, :location, :warehouse_type, presence: true
  validates :warehouse_type, inclusion: { in: ['calidad', 'no calidad'] }

  scope :high_quality, -> { where(warehouse_type: 'calidad') }
  scope :low_quality, -> { where(warehouse_type: 'no calidad') }

  after_create :create_shelves

  private

  def create_shelves
    number_of_shelves = self.shelves.count
  
    # Generamos 10 estantes por cada almacén
    (1..10).each do |shelf_number|
      # Creamos un nuevo estante
      shelf = self.shelves.create(warehouse_id: self.id)
  
      # Creamos las divisiones y particiones para ese estante
      (1..5).each do |division_number|
        (1..5).each do |partition_number|
          # Creamos una partición para ese estante
          shelf.shelf_partitions.create(
            division: division_number,
            partition: partition_number
          )
        end
      end
    end
  end