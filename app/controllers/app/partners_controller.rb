module App
  class PartnersController < BaseController
    before_action :set_partner, only: [:show]
  
    def show
    end

    def create
      @partner = Partner.new(partner_params)

      respond_to do |format|
        if @partner.save
          sign_in(:user, @partner.user)
          format.html { redirect_to cabinet_root_path, notice: 'Вітаємо! Ви успішно зареєструвались. Для продовження роботи підтвердіть вашу електронну адресу та заповніть інформацію про себе.' }
          format.json { render action: 'show', status: :created, location: @partner }
        else
          format.html {
            puts @partner.errors.full_messages
            redirect_to new_registration_path(:user), alert: "Помилка! #{@partner.errors.inject([]){|r, (k,v)| r << v}.join(' ')}"
          }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_partner
        @partner = Partner.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def partner_params
        params.require(:partner).permit(
          :name, :description, :info, :price, :location_id, 
          :site, :phone, category_ids: [], location_ids: [], 
          user_attributes: [:id, :email, :avatar, :avatar_remote_url, :password, :password_confirmation]
        )
      end
  end
end