module Cabinet
  class BaseController < ActionController::Base
    before_action :authenticate_user!
    before_action :authenticate_partner!
    protect_from_forgery with: :exception
    layout 'cabinet'

    def current_partner
      current_user.rolable
    end

    private

    def authenticate_partner!
      redirect_to root_path unless current_partner.is_a?(Partner)
    end
  end
end