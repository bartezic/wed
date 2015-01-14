module Admin
  class LocationsController < BaseController
    before_action :set_location, only: [:show, :edit, :update, :destroy]

    # GET /desks
    # GET /desks.json
    def index
      @locations = Location.order(id: :desc).page(params[:page]).per(25)
    end

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/new
    def new
      @location = Location.new
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /desks
    # POST /desks.json
    def create
      @location = Location.new(location_params)

      respond_to do |format|
        if @location.save
          format.html { redirect_to [:admin, @location], notice: 'Location was successfully created.' }
          format.json { render action: 'show', status: :created, location: @location }
        else
          format.html { render action: 'new' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @location.update(location_params)
          format.html { redirect_to [:admin, @location], notice: 'Location was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /desks/1
    # DELETE /desks/1.json
    def destroy
      @location.destroy
      respond_to do |format|
        format.html { redirect_to admin_locations_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_location
        @location = Location.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:name, :name_m, :slug)
      end
  end
end
