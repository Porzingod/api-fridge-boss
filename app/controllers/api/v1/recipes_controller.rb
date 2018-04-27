module Api::V1
  class RecipesController < ApplicationController
    def create
      recipe = Recipe.new(recipe_params)
      if recipe.save
        user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: recipe.id)
        if !user_recipe
          UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        end
        
        render json: recipe
      else
        recipe = Recipe.find_by(recipeId: params[:recipe][:recipeId])
        user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: recipe.id)
        if !user_recipe
          UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        end
        
        render json: recipe
      end
    end

    private

    def recipe_params
      params.require(:recipe).permit(:recipeName, :recipeId, :totalTimeInSeconds, :smallImageUrls, :ingredients)
    end
  end
end
