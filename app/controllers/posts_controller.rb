class PostsController < ApplicationController
  layout :get_layout
  def new
    @user = User.find(params[:user_id])
    @post = @user.tweets.new
    render :layout => false
  end

  def index
    @user = current_user
    @posts = Tweet.where("user_id = '#{@user.id}' and post_box IS NULL and users.school_admin_id = '#{@user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order("created_at Desc").paginate :page => params[:index_page], :per_page => 10
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.tweets.new(params[:tweet])
    @post.user_id = current_user.id
    @post.receiver_id = @user.id
    if @post.save
      render :update do |page|
        flash[:notice] = "Successfully posted this user."
        page.redirect_to profiles_path
      end
    else
      if remotipart_submitted?
        respond_to do |format|
          format.js
        end
      end
    end
  end

  def repost
    @post = Tweet.find(params[:id])
    @repost = Tweet.new(:user_id => @post.user_id, :receiver_id => @post.receiver_id, :body => @post.body)
    if @repost.save
      @error = false
      flash[:notice] = "Successfully Reposted."
    else
      @error = true
      flash[:notice] = "Failed to Repost."
    end
    respond_to do |format|
      format.js
    end
  end

  def reply
    @post = Tweet.find(params[:id])
    @user = User.find(params[:user_id])
    if @post.tweet_id == nil
      @posts = Tweet.where("tweet_id = '#{params[:id]}' and users.school_admin_id = '#{current_user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order("created_at Asc")
    else
      @posts = Tweet.where("tweet_id = '#{@post.tweet_id}' or tweets.id = '#{@post.tweet_id}' and users.school_admin_id = '#{current_user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order("created_at Asc")
    end
    render :layout => false
  end

  def reply_post
    @post = Tweet.find(params[:id])
    if @post.tweet_id == nil
      @posts = Tweet.where("tweet_id = '#{params[:id]}'").order("created_at Asc")
    else
      @posts = Tweet.where("tweet_id = '#{@post.tweet_id}' or tweets.id = '#{@post.tweet_id}' and users.school_admin_id = '#{current_user.school_admin_id}'").joins("left join users on users.id = tweets.user_id").order("created_at Asc")
    end
    @repost = Tweet.new(params[:tweet])
    @repost.user_id = current_user.id
    if @post.tweet_id == nil
      @repost.tweet_id = @post.id
    else
      @repost.tweet_id = @post.tweet_id
    end
    body = params[:tweet][:body].split(' ')[0]
    @user = User.find_by_username(body)
    @repost.receiver_id = @user.present? ? @user.id : @post.user_id
    if @repost.save
      @post.update_attribute(:reply, true)
      UserMailer.reply_post(@post.user,@repost).deliver
      respond_to do |format|
        format.js
      end
    else
      if remotipart_submitted?
        respond_to do |format|
          format.js
        end
      end
    end
  end


  def show

  end

  def favourite
    @post = Tweet.find(params[:user_id])
    @favourite = Favorite.new(:user_id => current_user.id,:tweet_id=>@post.id,:status => true).save
    flash[:notice] = "Successfully Added to Favourates."
    respond_to do |format|
      format.js
    end
  end

  def update_favourite
    @post = Tweet.find(params[:user_id])
    @favourite = @post.favorite.update_attribute(:status, false)
    flash[:notice] = "Successfully Removed from Favourates."
  end

  def update_mark_favourite
    @post = Tweet.find(params[:user_id])
    @favourite = @post.favorite.update_attribute(:status, true)
    flash[:notice] = "Successfully Added to Favourates."
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.tweets.find(params[:id])
    @delete_post = @post.tweet_id
    if @post.destroy
      @delete = Tweet.find_by_tweet_id(@delete_post)
      if !@delete.present?
        Tweet.find(@delete_post).update_attribute(:reply, false) if @delete_post != nil
      end
      respond_to do |format|
        format.js{@post}
      end
    end
  end
end
