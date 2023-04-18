Rails.application.routes.draw do
  root to: "homes#index"
   devise_for :users
   resources :recipes
   resources :recipes do
     resources :comments, only: [:create, :destroy]
   end
end
