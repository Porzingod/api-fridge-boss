Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create, :destroy]
      resources :users, only: [:create, :show] do
        resources :ingredients, only: [:index, :show, :create, :update, :destroy]
      end
      resources :recipes, only: [:create]
      resources :recipe_ingredients, only: [:create]
      resources :recipe_ingredient_joins, only: [:create, :destroy]
      resources :user_recipes, only: [:create, :destroy]
    end
  end

end
