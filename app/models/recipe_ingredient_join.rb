class RecipeIngredientJoin < ApplicationRecord
  belongs_to :recipe
  belongs_to :recipe_ingredient
end
