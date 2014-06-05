class ImportentLinksController < ApplicationController
  before_filter :is_login?
  layout :get_layout

  def index
    @user = User.find(params[:class_id])
    1.times{@user.importent_links.new}
  end

  def upload_doc
    @user = User.find(params[:class_id])
    @user.attributes = params[:user]
    reject = @user.importent_links.inject(true){|truthiness, n| !!(truthiness && n.marked_for_destruction?) }
    if !reject and @user.save
      flash[:notice] = "Successfully given Importent Links"
      redirect_to class_path(@user)
    else
      1.times{@user.importent_links.build}
      flash[:error] = "Failed to give the Links"
      render :action => "index"
    end
  end

  def links
    @user = User.find(params[:class_id])
    @links = ImportentLink.where("user_id = #{@user.id}")
    render :layout => false
  end
end
