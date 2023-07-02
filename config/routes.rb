require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"

  resources :projects do
    member do
      get :upload
    end
    resources :texts, only: [:show, :create, :destroy]
  end

  OCRails::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
  end
end
