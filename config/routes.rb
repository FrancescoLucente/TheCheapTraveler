Rails.application.routes.draw do
  # Configura Devise con i controllori personalizzati
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # Configura il blocco devise_scope all'esterno di devise_for
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

resources :users, only: [] do
  patch 'make_admin', on: :collection
  patch 'make_mod', on: :collection
  patch 'remove_mod', on: :collection
end

  # Definisci la rotta principale
  root to: 'home#index'

  # Risorse e rotte personalizzate
  resources :trips do
    collection do
      post :search_trip  # Corretto il simbolo :search_trip
    end
  end
  
  resources :weathers
  resources :cities do
    resources :events, only: [:index, :show]
    resources :reviews, only: [:create, :destroy]
  end

  # Rotte personalizzate per il HomeController
  get 'suggest_cities', to: 'home#suggest_cities'
  get 'search_city', to: 'home#search_city', as: 'search_city'
  
  # Verifica dello stato di salute dell'applicazione
  get 'up' => 'rails/health#show', as: :rails_health_check
end
