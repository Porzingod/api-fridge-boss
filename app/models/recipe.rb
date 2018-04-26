class Recipe < ApplicationRecord
  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredient_joins
  has_many :recipe_ingredients, through: :recipe_ingredient_joins
end
