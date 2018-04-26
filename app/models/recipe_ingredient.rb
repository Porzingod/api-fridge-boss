class RecipeIngredient < ApplicationRecord
  validates :name, uniqueness: true

  has_many :recipe_ingredient_joins
  has_many :recipes, through: :recipe_ingredient_joins
end
