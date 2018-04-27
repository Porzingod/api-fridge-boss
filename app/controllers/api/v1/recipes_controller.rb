module Api::V1
  class RecipesController < ApplicationController
    def create
      recipe = Recipe.find_by(recipeId: params[:recipe][:recipeId])

      ingredients = []
      params[:ingredients].each do |ingr|
        ingredient = RecipeIngredient.find_by(name: ingr)
        if ingredient
          ingredients.push(ingredient)
        else
          ingredient = RecipeIngredient.create(name: ingr)
          ingredients.push(ingredient)
        end
      end

      if recipe
        user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: recipe.id)

        if !user_recipe
          UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        end
        render json: recipe
        
      else
        recipe = Recipe.create(recipe_params)
        user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: recipe.id)
        if !user_recipe
          UserRecipe.create(user_id: params[:user_id], recipe_id: recipe.id)
        end

        ingredients.each do |ingr|
          recipe_ingredient = RecipeIngredientJoin.find_by(recipe_id: recipe.id, recipe_ingredient_id: ingr.id)
          if !recipe_ingredient
            RecipeIngredientJoin.create(recipe_id: recipe.id, recipe_ingredient_id: ingr.id)
          end
        end
        render json: recipe
      end
    end

    private

    def recipe_params
      params.require(:recipe).permit(:recipeName, :recipeId, :totalTimeInSeconds, :smallImageUrls)
    end
  end
end
