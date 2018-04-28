class Recipe < ApplicationRecord
  validates :recipeId, uniqueness: true

  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredient_joins
  has_many :recipe_ingredients, through: :recipe_ingredient_joins
  has_many :recipe_cuisines
  has_many :cuisines, through: :recipe_cuisines
end
