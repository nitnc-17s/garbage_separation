class Category < ApplicationRecord
  has_many :garbages

  validates :name, presence: true
  validates :name, uniqueness: true
end
