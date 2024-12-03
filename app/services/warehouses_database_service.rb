class WarehousesDatabaseService
    def self.create_shelves(warehouse_id)
      10.times do
        Shelf.create!(warehouse_id: warehouse_id)
      end
    end
  
    #def self.total_shelf_partitions(warehouse_id)
    #  Shelf.joins(:shelf_partitions).where(warehouse_id: warehouse_id).count
    #end
  
    def self.update_output_pointer(warehouse_id, output_pointer)
      warehouse = Warehouse.find(warehouse_id)
      warehouse.update!(output_pointer: output_pointer)
    end
  
    def self.high_quality
      Warehouse.where(warehouse_type: 'calidad')
    end
  
    def self.low_quality
      Warehouse.where(warehouse_type: 'no calidad')
    end
  end
  