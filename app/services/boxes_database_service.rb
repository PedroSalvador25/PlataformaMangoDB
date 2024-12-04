class BoxesDatabaseService
  def self.fetch_hectares_for_combo
    Hectare.where.not(community: nil).map { |h| ["#{h.id} - #{h.community}", h.id] }
  end

  def self.create_box(box)
    success = false
    ActiveRecord::Base.transaction do
      success = box.save
    end
    { success: success, box: box }
  end

  def self.update_box(box, params)
    success = false
    ActiveRecord::Base.transaction do
      success = box.update(params)
    end
    { success: success }
  end

  def self.destroy_box(box)
    success = false
    ActiveRecord::Base.transaction do
      success = box.destroy
    end
    success
  end

  def self.release_kilos(box, kilos_to_release)
    ActiveRecord::Base.transaction do
      remaining_kilos = kilos_to_release.to_f
      warehouse = box.shelf_partition&.shelf&.warehouse

      raise "No hay particiones con cajas disponibles" unless box.shelf_partition

      while remaining_kilos.positive?
        current_partition = box.shelf_partition
        box_in_partition = current_partition.box

        if box_in_partition.nil? || box_in_partition.weigth.zero?
          ShelvesPartitionDatabaseService.clear_partition_box(current_partition.id)
          WarehousesDatabaseService.increment_output_pointer(warehouse)
          next
        end

        if box_in_partition.weigth >= remaining_kilos
          box_in_partition.update!(weigth: box_in_partition.weigth - remaining_kilos)
          remaining_kilos = 0
        else
          remaining_kilos -= box_in_partition.weigth
          box_in_partition.update!(weigth: 0)
          ShelvesPartitionDatabaseService.clear_partition_box(current_partition.id)
          WarehousesDatabaseService.increment_output_pointer(warehouse)
        end
      end
    end
  end
end


  