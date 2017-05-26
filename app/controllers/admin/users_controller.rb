module Admin
  class UsersController < BaseController
    before_action :skip_trackable, only: [:login_as, :back]

    def login_as
      raise ActiveRecord::RecordNotFound unless current_user && current_user.is_manager? && (user = User.find(params[:id]))
      Rails.logger.info "LOGIN_AS: was: #{current_user.id} now: #{user.id}"
      sign_in(:user, user)
      session[:old_user_id] = current_user.id
      session[:referrer] = request.referrer
      redirect_to cabinet_root_path
    end

    def back
      if session[:old_user_id]
        u = User.find(session[:old_user_id])
        Rails.logger.info "LOGIN_BACK: was: #{current_user.id} now: #{u.id}"
        sign_in(:user, u)
        session.delete(:old_user_id)
        cookies['profile_type'] = 'manager'
        redirect_to session[:referrer] || admin_root_path
      else
        redirect_to root_path
      end
    end

    private

      def skip_trackable
        request.env['devise.skip_trackable'] = true
      end

  end
end
