class Cuisine < ApplicationRecord
  validates :name, uniqueness: true
  has_many :recipe_cuisines
  has_many :recipes, through: :recipe_cuisines

end
