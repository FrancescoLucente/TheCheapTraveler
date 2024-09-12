# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: [:make_admin, :remove_mod]
  before_action :authorize_admin_or_mod, only: [:make_mod]

  # Azione per nominare un utente Admin
  def make_admin
    user = User.find_by(email: params[:email])
    if user
      user.update(role: 'admin')
      flash[:notice] = "#{user.email} è stato nominato Admin."
    else
      flash[:alert] = "Utente non trovato."
    end
    redirect_to root_path
  end

  # Azione per nominare un utente Mod
  def make_mod
    user = User.find_by(email: params[:email])
    if user
      user.update(role: 'mod')
      flash[:notice] = "#{user.email} è stato nominato Mod."
    else
      flash[:alert] = "Utente non trovato."
    end
    redirect_to root_path
  end

  # Azione per rimuovere il ruolo di Mod da un utente
  def remove_mod
    user = User.find_by(email: params[:email])
    if user && user.mod?
      user.update(role: 'user')
      flash[:notice] = "#{user.email} è stato rimosso come Mod."
    else
      flash[:alert] = "Utente non trovato o non è un Mod."
    end
    redirect_to root_path
  end

  private

  # Solo gli admin possono eseguire certe azioni
  def authorize_admin
    unless current_user.admin?
      flash[:alert] = "Non hai i permessi per eseguire questa azione."
      redirect_to root_path
    end
  end

  # Admin e Mod possono eseguire certe azioni
  def authorize_admin_or_mod
    unless current_user.admin? || current_user.mod?
      flash[:alert] = "Non hai i permessi per eseguire questa azione."
      redirect_to root_path
    end
  end
end
