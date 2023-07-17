class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :switch_locale

  def switch_locale
    locale = params[:locale] || I18n.default_locale
    I18n.locale = locale
    @pagy_locale = locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  protected

  def authenticate_admin!
    authenticate_user!

    unless current_user.admin?
      flash[:alert] = I18n.t("errors.messages.not_authorized")
      render "home/index", status: :not_found
    end
  end
end
