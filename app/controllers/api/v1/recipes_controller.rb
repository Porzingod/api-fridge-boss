module Api::V1
  class RecipesController < ApplicationController
    def create
      recipe = Recipe.new(recipe_params)
      if recipe.save
        UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        byebug
        render json: recipe
      else
        recipe = Recipe.find_by recipeId: params[:recipe][:recipeId]
        UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        byebug
        render json: recipe
      end
    end

    private

    def recipe_params
      params.require(:recipe).permit(:recipeName, :recipeId, :totalTimeInSeconds, :smallImageUrls, :ingredients)
    end
  end
end
