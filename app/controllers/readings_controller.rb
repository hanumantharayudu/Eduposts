class ReadingsController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def new
    @class_id = params[:class_id]
    @subject_id = params[:subject_id]
    @user_id = params[:user_id]
    @school_admin_id = SchoolAdmin.find(params[:school_name])
    @readings = [Reading.new()]
  end
  
  def create
    @school_admin_id = SchoolAdmin.find(params[:school_name])
    @class_id = params[:class_id]
    params[:reads].each do |rd|
      rad = Reading.new(rd.last)
      rad.subject_id = params[:subject_id]
      rad.cls_id = @class_id
      rad.school_admin_id = params[:school_name]
      rad.user_id = params[:user_id]
      rad.save
    end
    flash[:notice] = "Reading given Succesfully"
    redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>@class_id,:subject_id=>params[:subject_id])
  end

  def readings
    @user = User.find(params[:class_id])
    @readings = Reading.where("user_id = #{@user.id}")
    render :layout => false
  end
  
  def index
    @readings = Reading.where("user_id = #{current_user.id}")
  end
  
  def student_subject_readings
    @readings = Reading.where("subject_id = #{params[:subject_id]}")
  end
  
end
