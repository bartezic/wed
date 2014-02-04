module Cabinet
  class GalleriesController < BaseController
    before_action :set_gallery, only: [:show, :edit, :update, :destroy]

    # GET /galleries
    # GET /galleries.json
    def index
      @galleries = current_partner.galleries.includes(:translations).page(params[:page]).per(25)
    end

    # GET /galleries/1
    # GET /galleries/1.json
    def show
    end

    # GET /galleries/new
    def new
      @gallery = Gallery.new
    end

    # GET /galleries/1/edit
    def edit
    end

    # POST /galleries
    # POST /galleries.json
    def create
      @gallery = current_partner.galleries.build(gallery_params)

      respond_to do |format|
        if @gallery.save && update_translations
          format.html { redirect_to [:cabinet, @gallery], notice: 'Gallery was successfully created.' }
          format.json { render action: 'show', status: :ok, location: @gallery }
          format.js { render json: { type: :create, gallery: @gallery }, status: :ok }
        else
          format.html { render action: 'new' }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
          format.js { render json: { type: :create, errors: @gallery.errors }, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /galleries/1
    # PATCH/PUT /galleries/1.json
    def update
      respond_to do |format|
        if @gallery.update(gallery_params) && update_translations
          format.html { redirect_to [:cabinet, @gallery], notice: 'Gallery was successfully updated.' }
          format.json { head :no_content }
          format.js { render json: { type: :update, gallery: @gallery }, status: :ok }
        else
          format.html { render action: 'edit' }
          format.json { render json: @gallery.errors, status: :unprocessable_entity }
          format.js { render json: { type: :update, errors: @gallery.errors }, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /galleries/1
    # DELETE /galleries/1.json
    def destroy
      @gallery.destroy
      respond_to do |format|
        format.html { redirect_to cabinet_galleries_url }
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

      def update_translations
        if params[:gallery][:translations]
          current_locale = I18n.locale
          params[:gallery][:translations].values.each do |translation|
            I18n.locale = translation['locale'].to_sym
            @gallery.update({
              name: translation['name'],
              description: translation['description']
            })
          end
          I18n.locale = current_locale
        else
          true
        end
      end
    end
end
