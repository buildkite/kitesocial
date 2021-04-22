Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :session

  resources :chirps do
    resource :like
  end

  resources :users do
    resource :follow
  end

  get "/firehose", to: "home#firehose"

  root "home#timeline"
end
