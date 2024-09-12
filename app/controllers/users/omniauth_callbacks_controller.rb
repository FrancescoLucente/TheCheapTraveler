class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # Callback per Google OAuth2
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Rimuove informazioni sensibili
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  # Callback per Facebook
  def facebook
    handle_auth('Facebook')
  end

  # Callback per GitHub
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    else
      session["devise.github_data"] = request.env['omniauth.auth'].except(:extra)
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end
  

  # Metodo generico per gestire l'autenticazione di Facebook e GitHub
  def handle_auth(kind)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      session["devise.#{kind.downcase}_data"] = request.env['omniauth.auth'].except(:extra) # Rimuove dati sensibili
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  # In caso di errore nell'autenticazione, reindirizza alla root
  def failure
    redirect_to root_path
  end
end
