module Cabinet
  class PartnersController < BaseController
    before_action :set_partner, only: [:show, :edit, :update, :days]

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/1/edit
    def edit
      @section = params[:section].try(:to_sym) || :general
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @partner.update(partner_params) && update_translations
          format.html { redirect_to :back, notice: 'Partner was successfully updated.' }
          format.json { head :no_content }
          format.js { render json: { success: true } }
        else
          format.html { redirect_to :back, alert: @partner.get_errors }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
          format.js { render json: { success: false } }
        end
      end
    end

    def days
      day = Day.find_by(day_of_life: params[:day])
      if day
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
          user_attributes: [:id, :email, :avatar, :avatar_remote_url, :password, :password_confirmation]
        )
      end

      def update_translations
        if params[:partner][:translations]
          params[:partner][:translations].values.each do |translation|
            I18n.locale = translation['locale'].to_sym
            @partner.update({
              name: translation['name'],
              description: translation['description'],
              info: translation['info']
            })
          end
        else
          true
        end
      end
  end
end