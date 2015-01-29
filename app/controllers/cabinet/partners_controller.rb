module Cabinet
  class PartnersController < BaseController
    before_action :set_partner, only: [:edit, :update, :days]

    def edit
      @section = params[:section].try(:to_sym) || :general
    end

    def update
      respond_to do |format|
        if @partner.update(partner_params)
          sign_in(@partner.user, bypass: true) if @partner == current_partner
          format.html { redirect_to :back, notice: 'Профіль успішно оновлено.' }
          format.json { head :no_content }
          format.js { render json: { success: true } }
        else
          format.html { redirect_to :back, alert: @partner.errors.full_messages }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
          format.js { render json: { success: false } }
        end
      end
    end

    def days
      if day = Day.find_by(day_of_life: params[:day])
        if params[:add] == 'true'
          @partner.days << day
        else
          @partner.days.delete(day)
        end
        render json: { success: true }
      else
        render json: { success: false }, status: 500
      end
    end

    def sort
      items = current_partner.send(params[:type].to_sym)
      params[:ids].reverse.each_with_index do |id, index|
        item = items.detect{|i| i.id == id.to_i }
        item.update_attribute(:position, index) if item.position != index
      end
      render json: { success: true }
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_partner
        @partner = current_partner
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def partner_params
        params.require(:partner).permit(
          :name, :description, :info, :location_id, 
          :site, :phone, :active, :premium, :premium_to, :slug,
          :rating, :callendar, location_ids: [], day_ids: [],
          involvings_attributes: [:id, :category_id, :price, :_destroy],
          user_attributes: [:id, :email, :avatar, :avatar_remote_url, :password, :password_confirmation, :temp_password]
        )
      end
  end
end