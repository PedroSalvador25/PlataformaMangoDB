class Shelf < ApplicationRecord
    belongs_to :warehouse
    belongs_to :box, optional: true
#   has_many :boxes change to

    validates :division, presence: true, inclusion: { in: 1..5 }
    validates :partition, presence: true, inclusion: { in: 1..5 }
    validates :warehouse_id, presence: true
    
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
end