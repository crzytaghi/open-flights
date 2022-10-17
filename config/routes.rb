Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'pages#index'

  namespace :api do
    namespace :v1 do
      # sets the primary paramter as the slug value as opposed to the :id value of the resource
      resources :airlines, param: :slug
      resources :reviews, only: [:create, :destroy]
    end
  end

  # route requests that arent for existing paths pre-defined in our api to our pages#index path
  get '*path', to: 'pages#index', via: :all
end
