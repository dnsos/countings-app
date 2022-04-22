# Application controller
class ApplicationController < ActionController::Base
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def authenticate_admin!
    authenticate_user!
    flash[:alert] = I18n.t('errors.messages.not_authorized') unless current_user
      .admin?

    render 'home/index', status: :not_found unless current_user.admin?
  end
end
