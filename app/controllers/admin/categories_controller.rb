module Admin
  class CategoriesController < BaseController
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    # GET /desks
    # GET /desks.json
    def index
      @categories = Category.all
    end

    # GET /desks/1
    # GET /desks/1.json
    def show
    end

    # GET /desks/new
    def new
      @category = Category.new
    end

    # GET /desks/1/edit
    def edit
    end

    # POST /desks
    # POST /desks.json
    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save && update_translations
          format.html { redirect_to @category, notice: 'Category was successfully created.' }
          format.json { render action: 'show', status: :created, location: @category }
        else
          format.html { render action: 'new' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /desks/1
    # PATCH/PUT /desks/1.json
    def update
      respond_to do |format|
        if @category.update(category_params) && update_translations
          format.html { redirect_to [:admin, @category], notice: 'Category was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /desks/1
    # DELETE /desks/1.json
    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to admin_categories_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_category
        @category = Category.friendly.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def category_params
        params.require(:category).permit(:name, :name_sing, :slug)
      end

      def update_translations
        params[:category][:translations].values.each do |translation|
          I18n.locale = translation['locale'].to_sym
          @category.update( name: translation['name'], name_sing: translation['name_sing'] )
        end
      end
  end
end