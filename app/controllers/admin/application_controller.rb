class Admin::ApplicationController < Administrate::ApplicationController
  before_action :authenticate_admin_user!
end
