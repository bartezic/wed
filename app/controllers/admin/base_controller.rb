module Admin
  class BaseController < ActionController::Base
    before_action :authenticate_user!
    before_action :authenticate_manager!
    layout 'admin'

    def current_manager
      current_user.rolable
    end

    private

    def authenticate_manager!
      redirect_to root_path unless current_manager.is_a?(Manager)
    end
  end
end