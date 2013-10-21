class OmniauthCallbacksController < ApplicationController
  def facebook 
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  # something weird going on here with google log in
  # user is created and logged in but then given a routing error, --- check callback thing, try to diagnose at the controller level
  def google_oauth2
    user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
      #set_flash_message(:notice, :success, :kind => "Facebook")
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
