module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_manager!
    layout 'admin'
  end
end