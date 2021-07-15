class SeparationNote < ApplicationRecord
  belongs_to :separation

  validates :note,  presence: true
  validates :note_type,  presence: true
end
