class Shelf < ApplicationRecord
  belongs_to :warehouse
  has_many :shelf_partitions, dependent: :destroy
  has_many :boxes, through: :shelf_partitions

  validates :warehouse_id, presence: true

  after_create :create_divisions_and_partitions

  def available_spaces
    shelf_partitions.where(box_id: nil).count
  end

  def full?
    available_spaces.zero?
  end

  def empty?
    shelf_partitions.where.not(box_id: nil).empty?
  end

  def assign_box(box)
    raise "No hay espacio disponible en este estante" if full?
    if box.shelf_partition.present?
      raise "La caja ya está asignada a otra partición del estante"
    end
    current_partition = next_partition_for_input
    current_partition.update!(box: box)
    box.update!(shelf_partition: current_partition, shelf_id: self.id)
    warehouse.increment_input_pointer
  end
  

  def release_box
    raise "No hay cajas para retirar en este estante" if empty?

    current_partition = next_partition_for_output
    box = current_partition.box
    current_partition.update!(box: nil)

    warehouse.increment_input_pointer
    box
  end

  private

  def create_divisions_and_partitions
    (1..5).each do |division_number|
      (1..5).each do |partition_number|
        shelf_partitions.create!(
          division: division_number,
          partition: partition_number
        )
      end
    end
  end

  def next_partition_for_input
    shelf_partitions.where(box_id: nil)[warehouse.output_pointer]
  end

  def next_partition_for_output
    shelf_partitions.where.not(box_id: nil)[warehouse.input_pointer]
  end
end
