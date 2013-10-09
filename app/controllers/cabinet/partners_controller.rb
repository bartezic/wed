module Cabinet
  class PartnersController < BaseController
    before_action :set_partner, only: [:show, :edit, :update]

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/1/edit
    def edit
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @partner.update(partner_params) && update_translations
          format.html { redirect_to [:cabinet, @partner], notice: 'Partner was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
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
          :name, :description, :info, :price, :location_id, 
          :site, :email, :phone, :active, :premium, :premium_to, 
          :avatar, :rating, :slug, :password, :password_confirmation,
          :avatar_remote_url, :category_ids => [], :location_ids => []
        )
      end

      def update_translations
        params[:partner][:translations].values.each do |translation|
          I18n.locale = translation['locale'].to_sym
          @partner.update({
            name: translation['name'],
            description: translation['description'],
            info: translation['info']
          })
        end
      end
  end
end