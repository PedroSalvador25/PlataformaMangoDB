class BoxAssignmentService
  def self.assign_box(box)
    warehouse = Warehouse.where(warehouse_type: box.quality).first
    shelf = find_available_shelf(warehouse)
    
    if shelf
      shelf.assign_box(box)
    else
      false
    end
  end
  
  def self.remove_box
    oldest_box = Box.occupied.order(:updated_at).first
    if oldest_box
      oldest_box.unassign_from_shelf
      oldest_box
    else
      nil
    end
  end
  
  private
  
  def self.find_available_shelf(warehouse)
    warehouse.shelves.find { |shelf| shelf.available? }
  end
end

#Migraciones pendientes que voy a revisar el viernes xd

# # db/migrate/YYYYMMDDHHMMSS_add_warehouse_type_to_warehouses.rb
# class AddQualityTypeToWarehouses < ActiveRecord::Migration[7.2]
#   def change
#     add_column :warehouses, :warehouse_type, :string
#   end
# end

# # db/migrate/YYYYMMDDHHMMSS_remove_box_id_from_shelves.rb
# class RemoveBoxIdFromShelves < ActiveRecord::Migration[7.2]
#   def change
#     remove_column :shelves, :box_id, :bigint
#   end
# end

# # db/migrate/YYYYMMDDHHMMSS_add_shelf_id_to_boxes.rb
# class AddShelfIdToBoxes < ActiveRecord::Migration[7.2]
#   def change
#     add_reference :boxes, :shelf, foreign_key: true
#   end
# end