class PasswordsController < Devise::PasswordsController

  # GET /resource/password/new
  def new
    respond_to do |format|
      format.js
    end
  end

  # POST /resource/password
  def create
    render :update do |page|
      @user = User.find_by_email_and_role(params[:user][:email],params[:user][:role])
      if @user.present?
        resource = resource_class.send_reset_password_instructions(params[resource_name])
        flash[:notice] = I18n.t('devise.passwords.send_instructions')
        page.redirect_to '/'
      else
        @role = params[:user][:role] == 'student' ? '#error' : '#error2'
        page<<"$('#{@role}').show();"
      end
    end
  end
end
