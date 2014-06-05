class ReadingsController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def index
    @user = User.find(params[:class_id])
    1.times{@user.readings.new}
  end

  def upload_doc
    @user = User.find(params[:class_id])
    @user.attributes = params[:user]
    reject = @user.readings.inject(true){|truthiness, n| !!(truthiness && n.marked_for_destruction?) }
    if !reject and @user.save
      flash[:notice] = "Successfully given the Readings"
      redirect_to class_path(:school_name => current_user.school_admin.school,:id =>@user.id)
    else
      1.times{@user.readings.build}
      flash[:error] = "Failed to give the readings"
      render :action => "index"
    end
  end

  def readings
    @user = User.find(params[:class_id])
    @readings = Reading.where("user_id = #{@user.id}")
    render :layout => false
  end
end
