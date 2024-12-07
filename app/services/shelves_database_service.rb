class ShelvesDatabaseService
  def self.save_shelf(shelf)
    ActiveRecord::Base.transaction do
      shelf.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.update_shelf(shelf, attributes)
    ActiveRecord::Base.transaction do
      shelf.update!(attributes)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.delete_shelf(shelf)
    ActiveRecord::Base.transaction do
      shelf.destroy!
    end
  rescue ActiveRecord::RecordNotDestroyed
    false
  end

  def self.create_divisions_and_partitions(shelf_id)
    shelf = Shelf.find(shelf_id)
    ActiveRecord::Base.transaction do
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
end

  
  