require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"

  resources :projects do
    member do
      get :upload
    end
  end

  get "images/:id/position_up", to: "images#position_up", as: :image_position_up
  get "images/:id/position_down", to: "images#position_down", as: :image_position_down

  OCRails::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
  end
end
