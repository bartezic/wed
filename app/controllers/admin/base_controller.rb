module Admin
  class BaseController < ActionController::Base
    before_action :authenticate_manager!
    protect_from_forgery with: :exception
    before_filter :set_locale
    before_filter :configure_permitted_parameters, if: :devise_controller?
    layout 'admin'

    def set_locale
      session['locale'] = params[:locale] if params[:locale] && [:ru, :uk].include?(params[:locale].to_sym)
      I18n.locale = (session.has_key? 'locale' || !session['locale'].empty?) ? session['locale'] : I18n.default_locale
    end

    def authenticate_manager!
      authenticate_user! && current_user.rolable.is_a?(Manager)
    end

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
    end
  end
end