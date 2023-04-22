Rails.application.routes.draw do
  root to: "homes#index"
  post 'recipes/:id/cook', to: 'recipes#cook', as: 'cook_recipe'
  get 'recipes/search', to: 'recipes#search'
   devise_for :users
   resources :users, only: [:show]
   resources :recipes
  resources :users, only: [] do
    resources :recipes, only: [:index]
    resource :fridge, only: [:show]
  end
  resources :recipes do
    member do
      post 'made'
    end
  end
   resources :fridges, only: [:show] do
    resources :fridge_ingredients, only: [:create, :destroy]
  end
end
