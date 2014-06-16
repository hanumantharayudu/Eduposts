class TeachertweetsController < ApplicationController
  before_filter :is_login?
  layout :get_layout
  
  def new
    @class_id = params[:class_id]
    @subject_id = params[:subject_id]
    @user_id = params[:user_id]
    @post_box = params[:post]
    @school_admin_id = SchoolAdmin.find(params[:school_name]) 
    @tweet = Tweet.new
  end
  
  def create
    @class_id = params[:class_id]
    @school_admin_id = SchoolAdmin.find(params[:school_name]) 
    @subject_id = params[:subject_id]
    subject = Subject.find(params[:subject_id]) 
    @subject_students = Studentclass.where("cls_id = #{subject.cls_id}")
    @tweet = Tweet.new(params[:tweet])
    @tweet.user_id = params[:user_id]
    @tweet.post_box = params[:post_box]
    if @tweet.save 
      @subject_students.each do |s|
        @teacher_tweet = Teachertweet.create(:user_id=>params[:user_id],:subject_id=>@subject_id,:cls_id=>@class_id,:school_admin_id=>@school_admin_id.id,:receiver_id=>s.user.id,:tweet_id=>@tweet.id)
        @teacher_tweet.save
      end
      flash[:notice] = "Creating Post Successfully"
      redirect_to class_path(:school_name =>current_user.school_admin.school,:id=>@class_id,:subject_id=>params[:subject_id])
    else
      flash[:notice] = "Post Creating Failure"
      render :new
    end
  end
  
  def index
    @post_box = params[:post]
    @teacher_tweets = Teachertweet.where("user_id = #{current_user.id}")
  end
  
  def student_subject_posts
    @post_box = params[:post]
    @tweets = Teachertweet.where("subject_id = #{params[:subject_id]} and receiver_id = #{current_user.id}")
  end
  
  
end
