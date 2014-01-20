module Cabinet
  class PartnerAdsController < BaseController
    before_action :set_partner_ad, only: [:show, :edit, :update, :days]

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /galleries
    # POST /galleries.json
    def create
      @partner_ad = current_partner.partner_ads.build(partner_ad_params)

      respond_to do |format|
        if @partner_ad.save && update_translations
          format.html { redirect_to cabinet_profile_path(:ads), notice: 'Gallery was successfully created.' }
          format.json { render action: 'show', status: :created, location: @partner_ad }
        else
          format.html { render action: 'new' }
          format.json { render json: @partner_ad.errors, status: :unprocessable_entity }
        end
      end
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

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_partner_ad
        @partner_ad = PartnerAd.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def partner_ad_params
        params.require(:partner_ad).permit(
          :title, :description, :active, :active_to, :asset, :asset_remote_url
        )
      end

      def update_translations
        if params[:partner_ad][:translations]
          params[:partner_ad][:translations].values.each do |translation|
            I18n.locale = translation['locale'].to_sym
            @partner_ad.update({
              title: translation['title'],
              description: translation['description']
            })
          end
        else
          true
        end
      end
  end
end