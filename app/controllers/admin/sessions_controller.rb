class Admin::SessionsController < Devise::SessionsController
  layout :layout?

  def new
  end

  def create
    puts "VVVVVVVVVVVV"
    resource = warden.authenticate!(:scope => resource_name)
    puts resource.errors.inspect
    puts "VVVVVVVVVVVBBBBBB"
    flash[:notice] = "Successfully Login.."
    redirect_to admin_dashboards_path
  end

  def destroy
    signed_in = signed_in?(resource_name)
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_in
    redirect_to "/"
  end
end
