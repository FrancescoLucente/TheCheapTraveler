class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  
    # Disabilita il controllo CSRF per OmniAuth callbacks
    skip_before_action :verify_authenticity_token, if: :omniauth_request?
  
    private
  
    def omniauth_request?
      # Verifica se la richiesta proviene da OmniAuth
      params[:controller] =~ /users\/auth/
    end
  end
  