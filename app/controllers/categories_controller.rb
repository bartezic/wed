class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  # GET /desks/1
  # GET /desks/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end
end