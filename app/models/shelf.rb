class Shelf < ApplicationRecord
    belongs_to :warehouse
    belongs_to :box, optional: true
end
