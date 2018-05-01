module Api::V1
  class RecipesController < ApplicationController
    YUMMLY_ID_AND_KEY = "?_app_id=#{ENV["YUMMLY_APP_ID"]}&_app_key=#{ENV["YUMMLY_APP_KEY"]}"

    YUMMLY_RECIPES_URL = "http://api.yummly.com/v1/api/recipes"
    YUMMLY_GET_RECIPE_URL = "http://api.yummly.com/v1/api/recipe/"

    ALLOWED_INGR = "&allowedIngredient[]="
    ALLOWED_HOLIDAY = "&allowedHoliday[]=holiday^holiday-"
    yummlyHolidays = ["Christmas", "Summer", "Thanksgiving", "New+Year", "Super+Bowl", "Game+Day", "Halloween", "Hanukkah", "4th+of+July"]
    NEAREST_HOLIDAY = yummlyHolidays[1]
    ALLOWED_CUISINE = "&allowedCuisine[]=cuisine^cuisine-"
    ALLOWED_COURSE = "&allowedCourse[]=course^course-"
    ALLOWED_ALLERGY = "&allowedAllergy[]="
    ALLOWED_DIET = "&allowedDiet[]="

    def results(count, page)
      "&maxResult=#{count}&start=#{count * page}"
    end

    def fetch_recipes
      url = YUMMLY_RECIPES_URL + YUMMLY_ID_AND_KEY + ALLOWED_HOLIDAY + NEAREST_HOLIDAY + results(40, params[:q].to_i)
      fetch = RestClient.get(url)
      results = JSON.parse(fetch)
      render json: results
    end

    def search_recipes
      search_ingredients = ""
      params[:ingredients].map{|obj| obj["name"].split(" ").join("+")}.each{|str| search_ingredients += ALLOWED_INGR + str}
      filter_cuisine = ""
      if params[:cuisine]
        filter_cuisine = ALLOWED_CUISINE + params[:cuisine].downcase.split(" ").join("-")
      end
      filter_course = ""
      if params[:course]
        filter_course = ALLOWED_COURSE + params[:course]
      end
      filter_allergies = ""
      if params[:allergies]
        params[:allergies].map{|allergy| filter_allergies += ALLOWED_ALLERGY + allergy[:id].to_s + "^" + allergy[:name]}
      end
      filter_diets = ""
      if params[:diets]
        params[:diets].map{|diet| filter_diets += ALLOWED_DIET + diet[:id].to_s + "^" + diet[:name]}
      end
      url = YUMMLY_RECIPES_URL + YUMMLY_ID_AND_KEY + filter_cuisine + filter_course + filter_allergies + filter_diets + search_ingredients + results(40, params[:q].to_i)
      fetch = RestClient.get(url)
      results = JSON.parse(fetch)
      render json: results
    end

    def find_recipe
      url = YUMMLY_GET_RECIPE_URL + params[:q] + YUMMLY_ID_AND_KEY
      fetch = RestClient.get(url)
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
