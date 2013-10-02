class CategoriesController < ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @partners = @category.partners.includes(:translations).page params[:page]
  end
end