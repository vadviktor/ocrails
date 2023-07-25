require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'projects#index'

  resources :projects do
    member do
      get :upload
    end

    resources :images, only: %i[show destroy] do
      member do
        get :position_up
        get :position_down
        get :texts
        get :overlay

        get 'texts/:text_id/position_up', to: 'texts#position_up', as: :position_up_text
        get 'texts/:text_id/position_down', to: 'texts#position_down', as: :position_down_text
        get 'texts/:text_id/toggle_enabled', to: 'texts#toggle_enabled', as: :toggle_enabled_text
      end
    end
  end

  OCRails::Application.routes.draw do
    mount Sidekiq::Web => '/sidekiq'
  end
end
