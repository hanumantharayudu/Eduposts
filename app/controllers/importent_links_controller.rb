class ImportentLinksController < ApplicationController
  before_filter :is_login?
  layout :get_layout


  def links
    @user = User.find(params[:class_id])
    @links = ImportentLink.where("user_id = #{@user.id}")
    render :layout => false
  end
  
  def new
    @class_id = params[:class_id]
    @subject_id = params[:subject_id]
    @user_id = params[:user_id]
    @school_admin_id = SchoolAdmin.find(params[:school_name]) 
    @importent_links = [ImportentLink.new()]
  end
  
  def create
    @class_id = params[:class_id]
    @school_admin_id = SchoolAdmin.find(params[:school_name]) 
    params[:importent_links].each do |imp|
      imp = ImportentLink.new(imp.last)
      imp.subject_id = params[:subject_id]
      imp.cls_id = @class_id
      imp.school_admin_id = params[:school_name]
      imp.user_id = params[:user_id]
      imp.save
    end
    flash[:notice] = "Important Links given Succesfully"
    redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>@class_id,:subject_id=>params[:subject_id])
  end
  
  def index
    @links = ImportentLink.where("user_id = #{current_user.id}")
  end
  
  def student_subject_links
    @links = ImportentLink.where("subject_id = #{params[:subject_id]}")
  end
  
end
