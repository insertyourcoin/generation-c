module SearchHelper
  def result_add_link(result)
    if result[:user_id] == 0 || result[:user_id] == current_user.id
      return false
    else
      return true
    end
  end
end
