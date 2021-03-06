module Admin
  class PartnersController < BaseController
    before_action :set_partner, only: [:show, :edit, :update, :destroy]

    # GET /desks
    # GET /desks.json
    def index
      @partners = Partner.order(id: :desc).page(params[:page]).per(25)
    end

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/new
    def new
      @partner = Partner.new
      @partner.user = User.new
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /desks
    # POST /desks.json
    def create
      @partner = Partner.new(partner_params)
      @partner.user.skip_confirmation_notification!

      respond_to do |format|
        if @partner.save!
          format.html { redirect_to [:admin, @partner], notice: 'Partner was successfully created.' }
          format.json { render action: 'show', status: :created, location: @partner }
        else
          format.html { render action: 'new' }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @partner.update(partner_params)
          format.html { redirect_to [:admin, @partner], notice: 'Partner was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @partner.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /desks/1
    # DELETE /desks/1.json
    def destroy
      @partner.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
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
          :site, :phone, :active, :premium, :premium_to, :slug,
          :rating, category_ids: [], location_ids: [], 
          user_attributes: [:id, :email, :avatar, :avatar_remote_url, :password, :password_confirmation]
        )
      end
  end
end