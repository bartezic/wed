module App
  class BaseController < ActionController::Base
    include ApplicationHelper
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    layout 'application'
    before_filter :select_categories

    def select_categories
      @categories = Category.all
    end
  end
end