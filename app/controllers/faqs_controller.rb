class FaqsController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def index
    @user = User.find(params[:class_id])
    1.times{@user.faqs.new}
  end

  def upload_doc
    @user = User.find(params[:class_id])
    @user.attributes = params[:user]
    reject = @user.faqs.inject(true){|truthiness, n| !!(truthiness && n.marked_for_destruction?) }
    if !reject and @user.save
      flash[:notice] = "Successfully given faqs"
      redirect_to class_path(:school_name => current_user.school_admin.school,:id =>@user.id)
    else
      1.times{@user.faqs.build}
      flash[:error] = "Failed to give the faqs"
      render :action => "index"
    end
  end

  def faqs
    @user = User.find(params[:class_id])
    @faqs = Faq.where("user_id = #{@user.id}")
    render :layout => false
  end
end
