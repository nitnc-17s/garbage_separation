class Separation < ApplicationRecord
  belongs_to :city

  has_many :garbages

  validates :name, presence: true
  validates :name, uniqueness: { scope: :city }
end
