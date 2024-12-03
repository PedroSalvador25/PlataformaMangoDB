class ShelvesDatabaseService
    def self.create_divisions_and_partitions(shelf_id)
      shelf = Shelf.find(shelf_id)
      (1..5).each do |division_number|
        (1..5).each do |partition_number|
          ::ShelfPartition.create!(
            shelf_id: shelf.id,
            division: division_number,
            partition: partition_number
          )
        end
      end
    end
  end
  
  