class SchoolPasswordsController < Devise::PasswordsController
  layout :get_school_layout

  def new
    build_resource({})
  end

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      flash[:notice] = I18n.t('devise.passwords.send_instructions')
      redirect_to  root_path
    else
      respond_with(resource)
    end
  end


  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
  end
end
