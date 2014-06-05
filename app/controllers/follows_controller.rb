class FollowsController < ApplicationController

  def follow
    @user = User.find_by_id(params[:id])
    @follow = Follow.new(:user_id => current_user.id, :receiver_id => @user.id, :status => true)
    if @follow.save
      render :update do |page|
        page.reload
      end
    end
  end

  def unfollow
    @follow= Follow.find_by_user_id_and_receiver_id(current_user.id,params[:id])
    if @follow.update_attribute(:status,false)
      render :update do |page|
        page.reload
      end
    end
  end
  
  def update_follow
    @follow= Follow.find_by_user_id_and_receiver_id(current_user.id,params[:id])
    if @follow.update_attribute(:status,true)
      render :update do |page|
        page.reload
      end
    end
  end
end