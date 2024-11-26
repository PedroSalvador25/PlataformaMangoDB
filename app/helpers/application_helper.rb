module ApplicationHelper
  def user_has_role?(user, *roles)
    return false if user.nil?
    roles.include?(user.role.to_sym)
  end
end
