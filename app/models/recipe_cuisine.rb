class RecipeCuisine < ApplicationRecord
  belongs_to :recipe
  belongs_to :cuisine
end
