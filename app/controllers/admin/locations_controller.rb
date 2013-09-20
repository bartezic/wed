module Admin
  class LocationsController < BaseController
    def show
      @location = Location.friendly.find(params[:id])
    end

    def edit
      @location = Location.friendly.find(params[:id])
    end

    def update
      @location = Location.friendly.find(params[:id])
      update_translations
      redirect_to [:admin, @location]
    end

    def create
      @location = Location.create(location_params)
      @location.save
      update_translations
      redirect_to [:admin, @location]
    end

    def destroy
      @location = Location.friendly.find(params[:id])
      @location.destroy

      respond_to do |format|
        format.html { redirect_to admin_locations_path }
        format.json { head :no_content }
      end
    end

    private

    def location_params
      params[:location].permit(:name, :slug)
    end

    def update_translations
      params[:location][:translations].values.each do |translation|
        I18n.locale = translation['locale'].to_sym
        @location.update( name: translation['name'] )
      end
    end
  end
end
