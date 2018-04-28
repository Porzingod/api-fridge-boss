module Api::V1
  class RecipesController < ApplicationController
    YUMMLY_ID_AND_KEY = "?_app_id=#{ENV["YUMMLY_APP_ID"]}&_app_key=#{ENV["YUMMLY_APP_KEY"]}"

    YUMMLY_RECIPES_URL = "http://api.yummly.com/v1/api/recipes"
    YUMMLY_GET_RECIPE_URL = "http://api.yummly.com/v1/api/recipe/"

    ALLOWED_INGR = "&allowedIngredient[]="
    ALLOWED_HOLIDAY = "&allowedHoliday[]=holiday^holiday-"
    yummlyHolidays = ["Christmas", "Summer", "Thanksgiving", "New+Year", "Super+Bowl", "Game+Day", "Halloween", "Hanukkah", "4th+of+July"]
    NEAREST_HOLIDAY = yummlyHolidays[1]

    def results(count, page)
      "&maxResult=#{count}&start=#{count * page}"
    end

    def fetch_recipes
      fetch = RestClient.get(YUMMLY_RECIPES_URL + YUMMLY_ID_AND_KEY + ALLOWED_HOLIDAY + NEAREST_HOLIDAY + results(40, params[:q].to_i))
      results = JSON.parse(fetch)
      render json: results
    end

    def search_recipes
      searchIngredients = ""
      params[:ingredients].map{|obj| obj["name"].split(" ").join("+")}.each{|str| searchIngredients += ALLOWED_INGR + str}
      fetch = RestClient.get(YUMMLY_RECIPES_URL + YUMMLY_ID_AND_KEY + searchIngredients + results(40, params[:q].to_i))
      results = JSON.parse(fetch)
      render json: results
    end

    def find_recipe
      fetch = RestClient.get(YUMMLY_GET_RECIPE_URL + params[:q] + YUMMLY_ID_AND_KEY)
      results = JSON.parse(fetch)
      render json: results
    end

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

      cuisines = []
      params[:cuisines].each do |cuis|
        cuisine = Cuisine.find_by(name: cuis)
        if cuisine
          cuisines.push(cuisine)
        else
          cuisine = Cuisine.create(name: cuis)
          cuisines.push(cuisine)
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

        cuisines.each do |cuisine|
          recipe_cuisine = RecipeCuisine.find_by(recipe_id: recipe.id, cuisine_id: cuisine.id)
          if !recipe_cuisine
            RecipeCuisine.create(recipe_id: recipe.id, cuisine_id: cuisine.id)
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
