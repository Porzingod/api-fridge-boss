module Api::V1
  class UserRecipeController < ApplicationController
    def create
      user_recipe = UserRecipe.new(user_recipe_params)
      if user_recipe.save
        render json: user_recipe
      else
        render json: {errors: user_recipe.errors.full_messages}
      end
    end

    def destroy
    end

    private

    def user_recipe_params
      params.permit(:user_id, :recipe_id)
    end
  end
end
