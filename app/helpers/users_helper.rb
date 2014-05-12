module UsersHelper
  def configurations_list
    Rule.where(user_id: current_user)
  end
  def shared_rules_list
    Rule.where(user_id: 0)
  end
end
