class Shelf < ApplicationRecord
  belongs_to :warehouse
  has_many :shelf_partitions, dependent: :destroy

  validates :warehouse_id, presence: true

  after_create :create_divisions_and_partitions

  private

  def create_divisions_and_partitions
    ShelvesDatabaseService.create_divisions_and_partitions(self.id)
  end
end

