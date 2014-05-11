class LocaleController < ApplicationController
  def change
    params.require(:locale)
    params.permit(:locale)
    I18n.locale = params[:locale]
    redirect_to rules_path
  end
end
