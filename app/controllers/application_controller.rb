class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    session['locale'] = params[:locale] if params[:locale] && [:ru, :uk].include?(params[:locale].to_sym)
    I18n.locale = (session.has_key? 'locale' || !session['locale'].empty?) ? session['locale'] : I18n.default_locale
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end

end