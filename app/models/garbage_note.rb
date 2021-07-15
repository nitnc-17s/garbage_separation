class GarbageNote < ApplicationRecord
  belongs_to :garbage

  validates :note,  presence: true
  validates :note_type,  presence: true
end
