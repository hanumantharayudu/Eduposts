class AttendencesController < ApplicationController
  before_filter :is_login?
  layout :get_layout
  
  def new
    @school_name = SchoolAdmin.find(params[:school_name])
    @school_admin_id = params[:school_name]
    @class_id = params[:class_id]
    @user_id = params[:user_id]
    @subject_id = params[:subject_id]
    @receiver_id = params[:receiver_id]
    @attendence = Attendance.new
  end
  
  def create
    @school_name = SchoolAdmin.find(params[:school_name])
    @attendence = Attendance.new(params[:attendance])
    @attendence.school_admin_id = @school_name.id
    @attendence.cls_id = params[:class_id]
    @attendence.user_id = params[:user_id]
    @attendence.subject_id = params[:subject_id]
    @attendence.receiver_id = params[:receiver_id]
    if @attendence.save
      flash[:notice] = "Giving Attendance Successfully"
      redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>params[:class_id],:subject_id=>params[:subject_id])
    else
      flash[:notice] = "Attendance Given Failure"
      render :new
    end
  end
  
  def index
    @user = User.find(params[:receiver_id])
    @attendence_reports = Attendance.where("receiver_id = #{params[:receiver_id]}")
  end
end
