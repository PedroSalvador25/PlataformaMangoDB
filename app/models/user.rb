class User < ApplicationRecord
  has_secure_password

  before_validation :set_default_role, on: :create
  enum role: { Administrator: 0, WarehouseManager: 1, Tagger: 2, Seller: 3 }

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  def self.authenticate(email, password)
    user = UsersDatabaseService.find_user_with_lock(email)
  
    return { success: false, error: 'Credenciales incorrectas.' } if user.nil?
  
    if user.locked?
      return { success: false, error: 'Cuenta bloqueada. Inténtalo más tarde.' }
    elsif user.authenticate(password)
      ActiveRecord::Base.transaction do
        if user.connected?
          return { success: false, error: 'Credenciales incorrectas.' }
        else
          user.update!(connected: true, failed_attempts: 0)
        end
      end
      { success: true, user: user }
    else
      user.handle_failed_attempt
    end
  end
  

  def self.logout(user_id)
    user = UsersDatabaseService.find_user_by_id(user_id)
    user&.logout!
  end

  def save_record
    UsersDatabaseService.save_user(self)
  end

  def update_record(attributes)
    UsersDatabaseService.update_user(self, attributes)
  end

  def delete_record
    UsersDatabaseService.delete_user(self)
  end

  def logout!
    UsersDatabaseService.update_user(self, connected: false)
  end

  def lock_account!
    UsersDatabaseService.update_user(self, locked_until: 1.hour.from_now, failed_attempts: 0)
  end

  def unlock_account
    UsersDatabaseService.update_user(self, locked_until: nil, failed_attempts: 0)
  end

  def locked?
    locked_until.present? && locked_until > Time.current
  end

  def increment_failed_attempts!
    UsersDatabaseService.update_user(self, failed_attempts: failed_attempts.to_i + 1)
  end

  def reset_failed_attempts!
    UsersDatabaseService.update_user(self, failed_attempts: 0)
  end

  def connect!
    UsersDatabaseService.update_user(self, connected: true)
  end

  def handle_failed_attempt
    increment_failed_attempts!
    if failed_attempts >= 3
      lock_account!
      { success: false, error: 'Cuenta bloqueada debido a demasiados intentos fallidos.' }
    else
      { success: false, error: 'Credenciales incorrectas.' }
    end
  end

  def translated_role
    {
      "Administrator" => "Administrador",
      "WarehouseManager" => "Gerente de Almacén",
      "Tagger" => "Etiquetador",
      "Seller" => "Vendedor"
    }[role]
  end

  private

  def set_default_role
    self.role ||= :Tagger
  end
end




  
