class ShelfPartition < ApplicationRecord
  belongs_to :shelf
  belongs_to :box, optional: true
  
  validates :box_id, uniqueness: true, allow_nil: true
  validates :division, :partition, presence: true
  
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
    box.update!(shelf_partition: current_partition)
    warehouse.increment_input_pointer
  end
  
  def release_box
    raise "No hay cajas para retirar en este estante" if empty?
    current_partition = next_partition_for_output
    box = current_partition.box
    current_partition.update!(box: nil)
    warehouse.increment_output_pointer
    box
  end  

  private
  
  def next_partition_for_input
    shelf_partitions.where(box_id: nil)[warehouse.output_pointer]
  end

  def next_partition_for_output
    shelf_partitions[warehouse.output_pointer % shelf_partitions.count]
  end
end
