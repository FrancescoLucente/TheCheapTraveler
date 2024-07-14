# config/routes.rb

Rails.application.routes.draw do
  resources :cities do
    resources :events, only: [:index, :show]
  end

  # Rotte personalizzate per il HomeController
  post 'search_trip', to: 'home#search_trip'
  get 'suggest_cities', to: 'home#suggest_cities'

  get 'search_city', to: 'home#search_city', as: 'search_city'

  # Imposta la tua nuova pagina principale come root
  root 'home#index'

  # Definisci la rotta per la verifica dello stato di salute dell'applicazione
  get 'up' => 'rails/health#show', as: :rails_health_check
end
