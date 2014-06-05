class Admin::DashboardsController < ApplicationController
  before_filter :is_admin?
  layout :layout?

  def index
    @schools = SchoolAdmin.where("admin_id = #{current_admin.id}").all
  end
end
