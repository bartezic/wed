module Cabinet
  class PhotosController < BaseController
    before_action :set_photo, only: [:show, :edit, :update, :destroy]

    # GET /photos
    # GET /photos.json
    def index
      @photos = Photo.includes(gallery: :translations).where(gallery_id: current_partner.galleries.pluck(:id))
      
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @photos.map(&:to_jq_upload) }
      end
    end

    # GET /photos/1
    # GET /photos/1.json
    def show
    end

    # GET /photos/new
    def new
      @photo = Photo.new
    end

    # GET /photos/1/edit
    def edit
    end

    # POST /photos
    # POST /photos.json
    def create
      @photo = Photo.new(photo_params)

      respond_to do |format|
        if @photo.save
          format.html { redirect_to [:cabinet, @photo], notice: 'Photo was successfully created.' }
          format.json { render action: 'show', status: :created, location: @photo }
          format.js { render :layout => false }
        else
          format.html { render action: 'new' }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
          format.js { render :layout => false }
        end
      end
    end

    # PATCH/PUT /photos/1
    # PATCH/PUT /photos/1.json
    def update
      respond_to do |format|
        if @photo.update(photo_params)
          format.html { redirect_to [:cabinet, @photo], notice: 'Photo was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @photo.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /photos/1
    # DELETE /photos/1.json
    def destroy
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to cabinet_photos_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_photo
        @photo = Photo.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def photo_params
        params.require(:photo).permit(:asset, :asset_remote_url, :rating, :gallery_id)
      end
  end
end