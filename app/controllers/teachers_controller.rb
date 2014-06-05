class TeachersController < ApplicationController
  layout :get_school_layout, :except => ['edit', 'update']

  def new
    @school = SchoolAdmin.find(params[:school_id])
    @teacher = @school.users.new
  end

  def create
    @school = SchoolAdmin.find(params[:school_id])
    @teacher = @school.users.new(params[:user])
    @teacher.password = 'ashok123'
    @teacher.password_confirmation = 'ashok123'
    if @teacher.save
      @teacher.update_attribute(:role, 'teacher')
      @teacher.update_attribute(:confirmation_token,nil)
      @teacher.generate_password_reset_code
      flash[:notice] = "Sccessfully Send invitation to student"
      UserMailer.sent_teacher_invitation(@school,@teacher).deliver
      redirect_to school_path(@school)
    else
      flash[:error] = "Failed to Send Invitation"
      render :action => 'new'
    end
  end
  
  def index
    @school = SchoolAdmin.find(params[:school_id])
    @teachers = User.where("school_admin_id = '#{current_school_admin.id}' AND role = 'teacher'").all
    @assign_class = Teacherclass.new
  end

  def edit
    @teacher = User.find(params[:id])
    if @teacher.reset_password_token != params[:reset_password_token]
      render :text => 'Invalid Token.',:layout => false
    end
  end

  def show
    @school = SchoolAdmin.find(params[:school_id])
    @user = User.find(params[:id])
    @posts = Tweet.where("user_id = '#{@user.id}' and reply IS NULL").order("created_at Desc").paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html {render :partial => "show", :layout => false if request.xhr?}
      format.js {render :partial => "show", :layout => false if request.xhr?}
    end
  end

  def update
    @teacher = User.find(params[:id])
    if @teacher.update_attributes(params[:user])
      @teacher.update_attribute(:reset_password_token,nil)
      @teacher.update_attribute(:confirmation_token,nil)
      sign_in(@teacher, @teacher)
      redirect_to new_user1_home_path(current_user)
    else
      flash.now[:error] = "Loggened in failed."
      render :action => 'edit'
    end
  end

  def destroy
    @teacher = User.find(params[:id])
    if @teacher.destroy
      render :update do |page|
        flash[:notice] = "Successfully deleted this #{@teacher.role}."
        page.reload
      end
    end
  end
  
  def assign_class
    @school = SchoolAdmin.find(params[:school_id])
    @user = User.find(params[:id])
    @assign_class = Teacherclass.new
  end
  
  def assign_teachercls
    @assign_class = Teacherclass.create(params[:teacher_class])
    @assign_class.user_id = params[:id]
    @assign_class.school_admin_id = params[:school_id]
    @assign_class.cls_id = params[:class_id]
    @assign_class.subject_id = params[:class][:subject_id]
   
    if @assign_class.save
      @assign_class.subject.update_attribute(:assign, "Assigned")
      @subj = @assign_class.cls.subjects.where("assign is null")
      if !@subj.present?
        @assign_class.cls.update_attribute(:status, "Assigned")
      end
      flash[:notice] = "Successfully assign Subject to Teacher"
      redirect_to school_teachers_path(params[:school_id])
    else
      render :assign_class
    end
    
  end
  
  def assign_subject
    @subjects = Subject.where("assign is null and cls_id = ?", params[:teacher_id])
  end
  
end
