class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    case current_user.rolable_type
    when "Manager"
      admin_root_path
    when "Partner"
      cabinet_root_path
    end
  end

  def current_partner
    current_user.rolable
  end

  def current_manager
    current_user.rolable
  end

  def authenticate_partner!
    redirect_to root_path unless current_partner.is_a?(Partner)
  end

  def authenticate_manager!
    redirect_to root_path unless current_manager.is_a?(Manager)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit! }
  end
end