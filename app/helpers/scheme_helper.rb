module SchemeHelper
  def scheme_list
    ColorScheme.all
  end
  def get_background_color
    if ColorScheme.find(current_user[:color_scheme_id])[:scheme] == 'Light'
      return "rgb(255, 255, 255)"
    else
      return "rgb(0, 0, 0)"
    end
  end
  def get_grid_color
    if ColorScheme.find(current_user[:color_scheme_id])[:scheme] == 'Light'
      return "rgba(0, 0, 0, 0.1)"
    else
      return "rgba(255, 255, 255, 0.1)"
    end
  end
  def get_on_color
    if ColorScheme.find(current_user[:color_scheme_id])[:scheme] == 'Light'
      return 'rgb(44, 62, 80)'
    else
      return "rgb(35, 134, 180)"
    end
  end
  def get_off_color
    if ColorScheme.find(current_user[:color_scheme_id])[:scheme] == 'Light'
      return "rgb(255, 255, 255)"
    else
      return "rgb(0, 0, 0)"
    end
  end
end
