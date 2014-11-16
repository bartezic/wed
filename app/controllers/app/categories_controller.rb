module App
  class CategoriesController < BaseController
    def show
      @category = Category.friendly.find(params[:id])
      @partners = @category.partners.search(search_params, order_by)
      respond_to do |format|
        format.html
        format.js { render :show, layout: false }
      end
    end

    def index
      if params[:category_id]
        category = Category.find(params[:category_id])
        redirect_to category_path(category, search_params)
      end
    end
    
    private

    def search_params
      params.permit(:page, :date, :location_id)
    end
  end
end