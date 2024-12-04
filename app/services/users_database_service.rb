class UsersDatabaseService
  def self.save_user(user)
    ActiveRecord::Base.transaction do
      user.save!
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.update_user(user, attributes)
    ActiveRecord::Base.transaction do
      user.update!(attributes)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def self.delete_user(user)
    ActiveRecord::Base.transaction do
      user.destroy!
    end
  rescue ActiveRecord::RecordNotDestroyed
    false
  end

  def self.find_user_with_lock(email)
    User.lock.find_by(email: email)
  end

  def self.find_user_by_id(user_id)
    User.find_by(id: user_id)
  end
end


  
  