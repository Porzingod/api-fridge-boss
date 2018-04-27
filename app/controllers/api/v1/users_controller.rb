module Api::V1
  class UsersController < ApplicationController
    def create
    end

    def favorites
      user = User.find(params[:user_id])
      favorites = user.recipes
      favorites = favorites.each do |recipe|
        recipe.ingredients = recipe.recipe_ingredients.map {|ingr| ingr.name}
      end
      render json: favorites
    end

    private

    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end
