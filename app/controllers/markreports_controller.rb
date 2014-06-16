class MarkreportsController < ApplicationController
  before_filter :is_login?
  layout :get_layout
  
  def new
    @school_name = SchoolAdmin.find(params[:school_name])
    @school_admin_id = params[:school_name]
    @class_id = params[:class_id]
    @user_id = params[:user_id]
    @subject_id = params[:subject_id]
    @receiver_id = params[:receiver_id]
    @mark = Markreport.new
  end
  
  def create
    @school_name = SchoolAdmin.find(params[:school_name])
    @mark = Markreport.new(params[:markreport])
    @mark.school_admin_id = @school_name.id
    @mark.cls_id = params[:class_id]
    @mark.user_id = params[:user_id]
    @mark.subject_id = params[:subject_id]
    @mark.receiver_id = params[:receiver_id]
    if @mark.save
      flash[:notice] = "Creating Mark List Successfully"
      redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>params[:class_id],:subject_id=>params[:subject_id])
    else
      flash[:notice] = "Failed to Creating Mark List"
      render :new
    end
  end
  
  def index
    @school_name = SchoolAdmin.find(params[:school_name])
    @school_admin_id = params[:school_name]
    @class_id = params[:class_id]
    @user_id = params[:user_id]
    @subject_id = params[:subject_id]
    @receiver_id = params[:receiver_id]
    @student_name = User.find(params[:receiver_id])
    @marks_reports = Markreport.where("receiver_id = #{params[:receiver_id]}")
  end
  
  def edit
    @school_name = SchoolAdmin.find(params[:school_name])
    @class_id = params[:class_id]
    @user_id = params[:user_id]
    @subject_id = params[:subject_id]
    @receiver_id = params[:receiver_id]
    @mark = Markreport.find(params[:id])    
  end
  
  def update
    @mark = Markreport.find(params[:id])    
    if @mark.update_attributes(params[:markreport])
      redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>params[:class_id],:subject_id=>params[:subject_id])
    end
  end
  
  def destroy
    @mark = Markreport.find(params[:id])    
    if @mark.destroy
      redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>params[:class_id],:subject_id=>params[:subject_id])
    end
  end
  
  def student_subject_marks
    @subject_name = Subject.find(params[:subject_id])
    @marks_reports = Markreport.where("subject_id = #{params[:subject_id]} and receiver_id = #{current_user.id}")
  end
  
  
end
