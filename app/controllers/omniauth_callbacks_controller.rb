class OmniauthCallbacksController < ApplicationController
  def facebook
    raise request.env["omniauth.auth"].to_yaml
  end


end
