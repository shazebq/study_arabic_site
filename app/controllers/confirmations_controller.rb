class ConfirmationsController < Devise::ConfirmationsController
  def new
    super
  end

  def create
    super
  end

  # override devise here to redirect user to root path after he clicks on confirmation page
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_navigational_format?
      sign_in(resource_name, resource)
      #respond_with_navigational(resource){ redirect_to confirmation_getting_started_path }
      redirect_to root_path
    else
      respond_with_navigational(resource.errors, :status => :unprocessable_entity){ render_with_scope :new }
    end
  end
end
