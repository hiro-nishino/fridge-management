Rails.application.routes.draw do
  devise_for :users
  root to: "homes#index"
  post 'recipes/:id/cook', to: 'recipes#cook', as: 'cook_recipe'
  get 'recipes/search', to: 'recipes#search'
  resources :recipes do
    collection do
      get :search
    end
  end
  resources :users do
    resources :fridges do
      resources :fridge_ingredients
    end
  end
end
