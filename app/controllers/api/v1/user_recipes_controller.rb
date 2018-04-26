module Api::V1
  class UserRecipeController < ApplicationController
    def create
    end

    def destroy
    end

    private

    def user_recipe_params
      params.permit(:user_id, :recipe_id)
    end
  end
end
