module Cabinet
  class PhotosController < BaseController
    # POST /photos
    # POST /photos.json
    def create
      @photo = Photo.new(photo_params)

      respond_to do |format|
        if @photo.save
          format.js { render :layout => false }
        else
          format.js { render :layout => false }
        end
      end
    end

    # DELETE /photos/1
    # DELETE /photos/1.json
    def destroy
      @photo = Photo.find(params[:id])

      @photo.destroy
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Фото успішно видалено.' }
        format.json { head :no_content }
        format.js { render layout: false }
      end
    end

    private
      # Never trust parameters from the scary internet, only allow the white list through.
      def photo_params
        params.require(:photo).permit(:asset, :asset_remote_url, :rating, :gallery_id)
      end
  end
end