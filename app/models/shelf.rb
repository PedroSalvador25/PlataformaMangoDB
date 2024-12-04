class Shelf < ApplicationRecord
  belongs_to :warehouse
  has_many :shelf_partitions, dependent: :destroy

  validates :warehouse_id, presence: true

  after_create :create_divisions_and_partitions

  def save_record
    ShelvesDatabaseService.save_shelf(self)
  end

  def update_record(attributes)
    ShelvesDatabaseService.update_shelf(self, attributes)
  end

  def delete_record
    ShelvesDatabaseService.delete_shelf(self)
  end

  private

  def create_divisions_and_partitions
    ShelvesDatabaseService.create_divisions_and_partitions(self.id)
  end
end



