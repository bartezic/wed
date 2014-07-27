class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @partners = @category.partners.page params[:page]
  end
end