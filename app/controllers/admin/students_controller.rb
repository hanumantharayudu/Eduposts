class Admin::StudentsController < ApplicationController
  before_filter :is_admin?
  layout :layout?

  def show
    @user = User.find(params[:id])
    @post = @user.tweets.new(params[:tweet])
    @posts = Tweet.where("user_id = '#{@user.id}'").order("created_at Desc").paginate :page => params[:index_page], :per_page => 10
  end

  def followers
    @user = User.find(params[:id])
    @post = @user.tweets.new(params[:tweet])
    @users = User.where("confirmation_token IS NULL and id != '#{@user.id}'")
    @followers = @user.received_follows.where("status = #{true}")
  end

  def following
    @users = User.where("confirmation_token IS NULL")
    @user = User.find(params[:id])
    @post = @user.tweets.new(params[:tweet])
    @followers = Follow.where("status = #{true} and user_id = #{@user.id}")
  end
end
