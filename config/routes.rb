Rails.application.routes.draw do
  post 'recipes/:id/cook', to: 'recipes#cook', as: 'cook_recipe'
  get 'recipes/search', to: 'recipes#search'
  root to: "homes#index"
   devise_for :users
   resources :users, only: [:show]
   resources :recipes
   resources :users, only: [] do
    resources :recipes, only: [:index]
    resource :fridge, only: [:show]
  end
  resources :recipes do
    post 'made', on: :member
  end
   resources :fridge_ingredients, only: [:index]
   resources :fridges, only: [:show] do
    resources :fridge_ingredients, only: [:create, :destroy]
  end
end
