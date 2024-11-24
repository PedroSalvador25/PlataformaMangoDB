class User < ApplicationRecord
    has_secure_password
  
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }, if: :password_digest_changed?
  
    def lock_account!
      update(locked_until: 1.hour.from_now, failed_attempts: 0)
    end
  
    def unlock_account
      update(locked_until: nil, failed_attempts: 0)
    end
  
    def locked?
      locked_until.present? && locked_until > Time.current
    end
  
    def increment_failed_attempts!
      update(failed_attempts: failed_attempts.to_i + 1)
    end
  
    def reset_failed_attempts!
      update(failed_attempts: 0)
    end
  end
  