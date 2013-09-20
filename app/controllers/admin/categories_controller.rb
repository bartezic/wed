module Admin
  class CategoriesController < BaseController
    def show
      @category = Category.friendly.find(params[:id])
    end

    def edit
      @category = Category.friendly.find(params[:id])
    end

    def update
      @category = Category.friendly.find(params[:id])
      update_translations
      redirect_to [:admin, @category]
    end

    def create
      @category = Category.create(category_params)
      @category.save
      update_translations
      redirect_to [:admin, @category]
    end

    def destroy
      @category = Category.friendly.find(params[:id])
      @category.destroy

      respond_to do |format|
        format.html { redirect_to admin_categories_path }
        format.json { head :no_content }
      end
    end

    private

    def category_params
      params[:category].permit(:name, :name_sing, :slug)
    end

    def update_translations
      params[:category][:translations].values.each do |translation|
        I18n.locale = translation['locale'].to_sym
        @category.update( name: translation['name'], name_sing: translation['name_sing'] )
      end
    end
  end
end