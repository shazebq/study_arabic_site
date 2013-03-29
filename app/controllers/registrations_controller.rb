class RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to :controller => "student_profiles", action: "new"
  end

  def create
    redirect_to :controller => "student_profiles", action: "create"
  end

  # this is meant to override the path after a user creates an account and before it is confirmed
  # but it did not work for me
  #def after_inactive_sign_up_path_for(resource)
    #flash[:notice] = "A confirmation email has been sent to #{resource.email}. Please click on the confirm link in the email
    #                  to activate your account."
    #"/home"
  #end

end
