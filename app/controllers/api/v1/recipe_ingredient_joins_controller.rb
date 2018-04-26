module Api::V1
  class RecipeIngredientJoinsController < ApplicationController
    def create
    end

    def destroy
    end

    private

    def recipe_ingredient_join_params
      params.permit(:recipe_id, :ingredient_id)
    end
  end
end
