class SchemeController < ApplicationController
  def change
    scheme = ColorScheme.find(params[:id])
    current_user.update_attributes(color_scheme: scheme)
    redirect_to action: 'index', controller: "welcome"

  end
end
