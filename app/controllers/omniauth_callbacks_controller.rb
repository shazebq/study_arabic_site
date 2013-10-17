class OmniauthCallbacksController < ApplicationController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, notice: "Signed in!"
      #set_flash_message(:notice, :success, :kind => "Facebook")
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end


end
