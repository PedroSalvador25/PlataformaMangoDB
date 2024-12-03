class UsersDatabaseService
    def self.find_user_with_lock(email)
      User.lock.find_by(email: email)
    end
  
    def self.update_user(user, attributes)
      ActiveRecord::Base.transaction do
        user.update!(attributes)
      end
    end
    
    def self.find_user_by_id(user_id)
        User.find_by(id: user_id)
    end
  end

  
  