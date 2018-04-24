module Api::V1
  class IngredientsController < ApplicationController
    def index
      ingredients = User.find(params[:user_id]).ingredients
      render json: ingredients
    end

    def show
      # ingredients = Ingredient.select{|ingredient| ingredient.user_id == params[:user_id].to_i}
      ingredient = Ingredient.find(params[:ingredient_id])
      if ingredient
        render json: ingredient
      else
        render json: {errors: ingredient.errors.full_messages}
      end
    end

    def create
      ingredient = Ingredient.new(ingredient_params)
      if ingredient.save
        render json: ingredient
      else
        render json: {errors: ingredient.errors.full_messages}
      end
    end

    def update
    end

    def destroy
      ingredient = Ingredient.find(params[:id])
      ingredient.destroy
    end

    private

    def ingredient_params
      params.require(:ingredient).permit(:name, :expiration_date, :user_id)
    end

  end
end
