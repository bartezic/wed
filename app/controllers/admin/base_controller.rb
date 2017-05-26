module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_manager!, except: [:back]
    layout 'admin'
  end
end