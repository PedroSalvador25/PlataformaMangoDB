class WarehousesDatabaseService
  def self.save_warehouse(warehouse)
    ActiveRecord::Base.transaction do
      warehouse.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.update_warehouse(warehouse, attributes)
    ActiveRecord::Base.transaction do
      warehouse.update!(attributes)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.delete_warehouse(warehouse)
    ActiveRecord::Base.transaction do
      warehouse.destroy!
    end
  rescue ActiveRecord::RecordNotDestroyed
    false
  end

  def self.create_shelves(warehouse_id)
    10.times do
      Shelf.create!(warehouse_id: warehouse_id)
    end
  end

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

  