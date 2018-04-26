module Api::V1
  class RecipeIngredientsController < ApplicationController
    def create
      recipe_ingredient = RecipeIngredient.new(recipe_ingredient_params)
      if recipe_ingredient.save
        render json: recipe_ingredient
      else
        render json: {errors: recipe_ingredient.errors.full_messages}
      end
    end

    private

    def recipe_ingredient_params
      params.require(:recipe_ingredient).permit(:name)
    end
  end
end
