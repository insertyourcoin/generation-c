module UsersHelper
  def configurations_list
    Rule.where(user_id: current_user)
  end
end
