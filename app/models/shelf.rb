class Shelf < ApplicationRecord
  belongs_to :warehouse
  has_many :shelf_partitions, dependent: :destroy

  validates :warehouse_id, presence: true

  after_create :create_divisions_and_partitions

  private

  def create_divisions_and_partitions
    (1..5).each do |division_number|
      (1..5).each do |partition_number|
        shelf_partitions.create!(
          division: division_number,
          partition: partition_number
        )
      end
    end
  end
end
