class City < ApplicationRecord
  has_many :garbages
  has_many :separations

  validates :name, presence: true
  validates :name, uniqueness: true
end
