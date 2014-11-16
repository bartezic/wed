module App
  class BaseController < ActionController::Base
    include ApplicationHelper
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    layout 'application'
  end
end