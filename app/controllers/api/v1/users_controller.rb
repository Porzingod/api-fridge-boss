module Api::V1
  class UsersController < ApplicationController
    def create
      user = User.new(user_params)
      if user.save
        render json: user
      else
        render json: {errors: user.errors.full_messages}
      end
    end

    def favorites
      user = User.find(params[:user_id])
      favorites = user.recipes
      favorites = favorites.each do |recipe|
        recipe.ingredients = recipe.recipe_ingredients.map {|ingr| ingr.name}
        recipe.cuisines_list = recipe.cuisines.map {|cuisine| cuisine.name}
      end
      render json: favorites
    end

    private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
  end
end
