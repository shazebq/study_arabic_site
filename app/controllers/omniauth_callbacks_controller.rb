class OmniauthCallbacksController < ApplicationController
  def facebook 
    user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    deal_with_user(user) 
  end

  def google_oauth2
    raise request.env["omniauth.auth"].to_yaml
    #user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    #deal_with_user(user)
  end

  def deal_with_user(user)
    if user.persisted?
      sign_in_and_redirect user, notice: "Signed in!"
      #set_flash_message(:notice, :success, :kind => "Facebook")
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
