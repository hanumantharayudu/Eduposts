class ClsesController < ApplicationController
  layout :get_school_layout, :except => ['edit', 'update']
  
  def new
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.new
    1.times {@class.subjects.build}
  end
  
  def create
    @school = SchoolAdmin.find(params[:school_id])
    @class = Cls.new(params[:cls])
    @class.school_admin_id = @school.id
    if @class.save
      flash[:notice] = "class is created"
      redirect_to school_path(@school)
    else
      flash[:error] = "Failed to Send Invitation"
      render :action => 'new'
    end
  end
  
  def index
    @school = SchoolAdmin.find(params[:school_id])
    @classes = Cls.where("school_admin_id = '#{current_school_admin.id}'").all
  end
  
  
end
