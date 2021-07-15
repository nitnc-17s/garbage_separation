class Garbage < ApplicationRecord
  belongs_to :city
  belongs_to :category
  belongs_to :separation

  has_many :garbage_notes

  validates :name,  presence: true
  validates :name,  uniqueness: { scope: :city }
  validates :index, presence: true
  validates :index, uniqueness: { scope: :city }

  class << self
    def register_garbage(name, city_name, category_name, separation_name)
      city = City.find_by(name: city_name) || City.create!(name: city_name)
      category = Category.find_by(name: category_name) || Category.create!(name: category_name)
      separation = Separation.find_by(name: separation_name, city_id: city.id) \
        || city.separations.create!(name: separation_name)

      city.garbages.create!(name: name, index: Garbage.count, category: category, separation: separation)
    end

    def register_garbage!(name, city_name, category_name, separation_name)
      city = City.find_by!(name: city_name)
      category = Category.find_by!(name: category_name)
      separation = Separation.find_by!(name: separation_name, city_id: city.id)

      city.garbages.create!(name: name, index: Garbage.count, category: category, separation: separation)
    end
  end
end
