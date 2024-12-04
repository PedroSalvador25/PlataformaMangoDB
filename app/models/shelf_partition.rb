class ShelfPartition < ApplicationRecord
  belongs_to :shelf
  belongs_to :box, optional: true

  validates :box_id, uniqueness: true, allow_nil: true
  validates :division, :partition, presence: true

  def available_spaces
    ShelvesPartitionDatabaseService.count_available_spaces(self.shelf.id)
  end

  def full?
    available_spaces.zero?
  end

  def empty?
    ShelvesPartitionDatabaseService.all_occupied?(self.shelf.id)
  end

  def assign_box(box)
    raise "No hay espacio disponible en este estante" if full?
    if box.shelf_partition.present?
      raise "La caja ya está asignada a otra partición del estante"
    end

    ActiveRecord::Base.transaction do
      current_partition = next_partition_for_input
      ShelvesPartitionDatabaseService.update_partition_with_box(current_partition.id, box.id)
      ShelvesPartitionDatabaseService.update_box_with_partition(box.id, current_partition.id)
      shelf.warehouse.increment_input_pointer
    end
  end

  def release_box
    raise "No hay cajas para retirar en este estante" if empty?

    ActiveRecord::Base.transaction do
      current_partition = next_partition_for_output
      box = ShelvesPartitionDatabaseService.get_box_from_partition(current_partition.id)
      ShelvesPartitionDatabaseService.clear_partition_box(current_partition.id)
      shelf.warehouse.increment_output_pointer
      box
    end
  end

  private

  def next_partition_for_input
    ShelvesPartitionDatabaseService.find_available_partition(self.shelf.id, shelf.warehouse.output_pointer, lock: true)
  end

  def next_partition_for_output
    ShelvesPartitionDatabaseService.find_occupied_partition(self.shelf.id, shelf.warehouse.input_pointer, lock: true)
  end
end

