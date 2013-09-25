class CategoriesController < InheritedResources::Base  
  def show
    @category = Category.friendly.find(params[:id])
  end
end