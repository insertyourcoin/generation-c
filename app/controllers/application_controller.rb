class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :ensure_valid_email
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def ensure_valid_email
    # Ensure we don't go into an infinite loop
    return if action_name == 'add_email'

    # If the email address was the temporarily assigned one,
    # redirect the user to the 'add_email' page
    if current_user && (!current_user.email || current_user.email == User::TEMP_EMAIL)
      redirect_to add_user_email_path(current_user)
    end
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end
end
