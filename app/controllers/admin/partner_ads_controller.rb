module Admin
  class PartnerAdsController < BaseController
    before_action :set_partner_ad, only: [:show, :edit, :update, :destroy]

    # GET /desks
    # GET /desks.json
    def index
      @partner_ads = PartnerAd.includes(:translations).page(params[:page]).per(25)
    end

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/new
    def new
      @partner_ad = PartnerAd.new
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /desks
    # POST /desks.json
    def create
      @partner_ad = PartnerAd.new(partner_ad_params)

      respond_to do |format|
        if @partner_ad.save && update_translations
          format.html { redirect_to [:admin, @partner_ad], notice: 'partner_ad was successfully created.' }
          format.json { render action: 'show', status: :created, location: [:admin, @partner_ad] }
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
        if @partner_ad.update(partner_ad_params) && update_translations
          format.html { redirect_to [:admin, @partner_ad], notice: 'partner_ad was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @partner_ad.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /desks/1
    # DELETE /desks/1.json
    def destroy
      @partner_ad.destroy
      respond_to do |format|
        format.html { redirect_to admin_partner_ads_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_partner_ad
        @partner_ad = PartnerAd.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def partner_ad_params
        params.require(:partner_ad).permit(:title, :description, :asset, :asset_remote_url, :active, :active_to, :slug, :partner_id)
      end

      def update_translations
        if params[:partner_ad][:translations]
          params[:partner_ad][:translations].values.each do |translation|
            I18n.locale = translation['locale'].to_sym
            @partner_ad.update( title: translation['title'], description: translation['description'] )
          end
        else
          true
        end
      end
  end
end