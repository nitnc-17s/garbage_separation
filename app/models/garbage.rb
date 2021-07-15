class Garbage < ApplicationRecord
  belongs_to :city
  belongs_to :category
  belongs_to :separation

  has_many :garbage_notes

  validates :name,  presence: true
  validates :name,  uniqueness: { scope: :city }
  validates :index, presence: true
  validates :index, uniqueness: { scope: :city }
end
