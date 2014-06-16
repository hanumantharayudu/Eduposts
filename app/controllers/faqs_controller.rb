class FaqsController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def new
    @class_id = params[:class_id]
    @subject_id = params[:subject_id]
    @user_id = params[:user_id]
    @school_admin_id = SchoolAdmin.find(params[:school_name]) 
    @faqs = [Faq.new]
  end
  
  def create
    @school_admin_id = SchoolAdmin.find(params[:school_name])
    @class_id = params[:class_id]
    @faqs = [Faq.new]
    params[:faqs].each do |fq|
      faq = Faq.new(fq.last)
      faq.subject_id = params[:subject_id]
      faq.cls_id = @class_id
      faq.school_admin_id = params[:school_name]
      faq.user_id = params[:user_id]
      faq.save
    end
    flash[:notice] = "Faq given Succesfully"
    redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>@class_id,:subject_id=>params[:subject_id])
  end

  
  def index
    @faqs = Faq.where("user_id = #{current_user.id}")
  end
  
  def student_subject_faqs
    @faqs = Faq.where("subject_id = #{params[:subject_id]}")
  end
  
  
  
end
