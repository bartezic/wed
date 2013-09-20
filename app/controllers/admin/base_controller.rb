module Admin
  class BaseController < InheritedResources::Base
    before_action :authenticate_admin_user!
    layout 'admin'
  end
end