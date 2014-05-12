class WelcomeController < ApplicationController
  def index
    redirect_to rules_path if user_signed_in?
    redirect_to admin_index_path if admin_signed_in?
  end
end
