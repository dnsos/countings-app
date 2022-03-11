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
    flash[:alert] = 'Du bist nicht berechtigt, diese Aktion auszuführen.' unless current_user.admin?
    # This is not ideal yet because it results in the app stopping in the basic redirect page. This is because we can't really use a redirect with a non-30x status.
    # TODO: find a better UX for this.
    redirect_back_or_to locale_root_path, status: :forbidden unless current_user.admin?
  end
end
