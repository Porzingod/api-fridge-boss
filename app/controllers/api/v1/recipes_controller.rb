module Api::V1
  class RecipesController < ApplicationController
    def create
      recipe = Recipe.new(recipe_params)
      if recipe.save
        render json: {recipe: recipe, ingredients: recipe.ingredients}
      else
        render json: {errors: recipe.errors.full_messages}
      end
    end

    private

    def recipe_params
      params.require(:recipe).permit(:recipeName, :recipeId, :totalTimeInSeconds)
    end
  end
end
