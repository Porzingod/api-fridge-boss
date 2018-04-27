module Api::V1
  class UsersController < ApplicationController
    def create
    end

    def favorites
      user = User.find(params[:user_id])
      favorites = user.recipes
      render json: favorites
    end

    private

    def user_params
      params.require(:user).permit(:username, :password)
    end
  end
end
