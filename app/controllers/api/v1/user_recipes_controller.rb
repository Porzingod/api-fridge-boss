module Api::V1
  class UserRecipesController < ApplicationController
    def destroy
      recipe = Recipe.find_by(recipeId: params[:recipeId])
      user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: recipe.id)
      user_recipe.destroy
    end

  end
end
