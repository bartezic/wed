module Cabinet
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :authenticate_partner!
    layout 'cabinet'
  end
end