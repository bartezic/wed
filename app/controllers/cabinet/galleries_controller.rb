module Cabinet
  class GalleriesController < BaseController
    before_action :set_gallery, only: [:update, :destroy]

    # POST /galleries
    # POST /galleries.json
    def create
      @gallery = current_partner.galleries.build(gallery_params)

      respond_to do |format|
        if @gallery.save
          format.js { render json: { type: :create, gallery: @gallery }, status: :ok }
        else
          format.js { render json: { type: :create, errors: @gallery.errors }, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /galleries/1
    # PATCH/PUT /galleries/1.json
    def update
      respond_to do |format|
        if @gallery.update(gallery_params)
          format.js { render json: { type: :update, gallery: @gallery }, status: :ok }
        else
          format.js { render json: { type: :update, errors: @gallery.errors }, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /galleries/1
    # DELETE /galleries/1.json
    def destroy
      @gallery.destroy
      respond_to do |format|
        format.html { redirect_to cabinet_profile_path(:photo), notice: 'Галерею успішно видалено.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_gallery
        @gallery = Gallery.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def gallery_params
        params.require(:gallery).permit(:name, :description, :rating, :slug)
      end
    end
end
