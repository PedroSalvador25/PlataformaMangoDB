class ShelvesPartitionDatabaseService
    def self.count_available_spaces(shelf_id)
      ShelfPartition.where(shelf_id: shelf_id, box_id: nil).count
    end
  
    def self.all_occupied?(shelf_id)
      ShelfPartition.where(shelf_id: shelf_id).where.not(box_id: nil).empty?
    end
  
    def self.update_partition_with_box(partition_id, box_id)
      ActiveRecord::Base.transaction do
        ShelfPartition.lock.find(partition_id).update!(box_id: box_id)
      end
    end
  
    def self.update_box_with_partition(box_id, partition_id)
      ActiveRecord::Base.transaction do
        Box.lock.find(box_id).update!(shelf_partition_id: partition_id)
      end
    end
  
    def self.clear_partition_box(partition_id)
      ActiveRecord::Base.transaction do
        ShelfPartition.lock.find(partition_id).update!(box_id: nil)
      end
    end
  
    def self.get_box_from_partition(partition_id)
      ActiveRecord::Base.transaction do
        ShelfPartition.lock.find(partition_id).box
      end
    end
  
    def self.find_available_partition(shelf_id, pointer, lock: true)
      query = ShelfPartition.where(shelf_id: shelf_id, box_id: nil)
      query = query.lock if lock
      query[pointer]
    end
  
    def self.find_occupied_partition(shelf_id, pointer, lock: true)
      query = ShelfPartition.where(shelf_id: shelf_id).where.not(box_id: nil)
      query = query.lock if lock
      query[pointer]
    end
  end
  
  