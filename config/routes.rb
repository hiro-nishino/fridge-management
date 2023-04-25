Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  post 'recipes/:id/cook', to: 'recipes#cook', as: 'cook_recipe'
  get 'recipes/search', to: 'recipes#search'
   resources :recipes
  resources :users do
    resources :fridges, only: [:show, :edit, :update]do
      resources :fridge_ingredients, only: [:create, :destroy]
    end
  end
end
