Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  post 'recipes/:id/cook', to: 'recipes#cook', as: 'cook_recipe'
  get 'recipes/search', to: 'recipes#search'
   resources :recipes
   resources :users, only: [:show] do

     resource :fridge, only: [:show]
   end
   resources :recipes
   resources :fridges, only: [:show, :edit, :update] do
    resources :fridge_ingredients, only: [:create, :destroy]
  end
end
