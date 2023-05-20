Rails.application.routes.draw do
  get "projects/index"
  get "projects/show"
  get "projects/create"
  get "projects/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"

  resources :projects, only: [:index, :show, :create, :destroy] do
    resources :images, only: [:show, :create, :destroy] do
      resources :texts, only: [:show, :create, :destroy]
    end
  end
end
