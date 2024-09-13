class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2 facebook github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name if user.respond_to?(:name) # Assicurati che il campo 'name' esista
    end
  end
  before_create :set_default_role

  def set_default_role
    self.role ||= 'user'
  end

  # Helper methods per controllare i ruoli
  def admin?
    role == 'admin'
  end

  def mod?
    role == 'mod'
  end

  def user?
    role == 'user'
  end
end
