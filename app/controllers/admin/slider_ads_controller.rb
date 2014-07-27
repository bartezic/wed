module Admin
  class SliderAdsController < BaseController
    before_action :set_slider_ad, only: [:show, :edit, :update, :destroy]

    # GET /photos
    # GET /photos.json
    def index
      @slider_ads = SliderAd.page(params[:page]).per(25)
    end

    # GET /photos/1
    # GET /photos/1.json
    def show
    end

    # GET /photos/new
    def new
      @slider_ad = SliderAd.new
    end

    # GET /photos/1/edit
    def edit
    end

    # POST /photos
    # POST /photos.json
    def create
      @slider_ad = SliderAd.new(slider_ad_params)

      respond_to do |format|
        if @slider_ad.save
          format.html { redirect_to [:admin, @slider_ad], notice: 'Slider Ad was successfully created.' }
          format.json { render action: 'show', status: :created, location: @slider_ad }
        else
          format.html { render action: 'new' }
          format.json { render json: @slider_ad.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /photos/1
    # PATCH/PUT /photos/1.json
    def update
      respond_to do |format|
        if @slider_ad.update(slider_ad_params)
          format.html { redirect_to [:admin, @slider_ad], notice: 'Slider Ad was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @slider_ad.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /photos/1
    # DELETE /photos/1.json
    def destroy
      @slider_ad.destroy
      respond_to do |format|
        format.html { redirect_to admin_slider_ads_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_slider_ad
        @slider_ad = SliderAd.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def slider_ad_params
        params.require(:slider_ad).permit(:partner_id, :asset, :asset_remote_url, :active, :active_to, 
                                          text: [:title, :subtitle])
      end
  end
end