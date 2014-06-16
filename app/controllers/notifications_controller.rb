class NotificationsController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def index
    @posts = Tweet.where("body like '@%' and receiver_id = #{current_user.id} and user_id != #{current_user.id} and post_box IS NULL and users.school_admin_id = '#{current_user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order('created_at desc').paginate :page => params[:page], :per_page => 8
    respond_to do |format|
      format.html {render :partial => "index", :layout => false if request.xhr?}
      format.js {render :partial => "index", :layout => false if request.xhr?}
    end
  end

  def announcements
    @user = User.find(params[:id])
    @header = params[:post].present? ? "#{params[:post].capitalize}s" : " "
    @posts = Tweet.where("tweet_id IS NULL and post_box = '#{params[:post]}' and users.school_admin_id = '#{@user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order('created_at desc').paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.js
    end
  end
  

end
