class Shelf < ApplicationRecord
    belongs_to :warehouse
    has_many :shelf_partitions, dependent: :destroy

    validates :warehouse_id, presence: true
    after_create :create_divisions_and_partitions

    def available?
      boxes.count < 5
    end
  
    def assign_box(box)
      if available?
        boxes << box
        box.update(occupied: true)
        true
      else
        false
      end
    end
  
    def release_box(box)
      if boxes.include?(box)
        boxes.delete(box)
        box.update(occupied: false)
        true
      else
        false
      end
    end
  
    def occupied_spaces
      boxes.count
    end
  
    def available_spaces
      5 - occupied_spaces
    end
  private

  def create_divisions_and_partitions
    (1..5).each do |division_number|
      (1..5).each do |partition_number|
        self.shelf_partitions.create!(
          division: division_number,
          partition: partition_number
        )
      end
    end
  end
end
