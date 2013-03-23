RailsAdmin.config do |config|
  config.attr_accessible_role { :admin }

  config.authorize_with do |controller|
    unless current_user.try(:admin?)
      flash[:notice] = "You are not an admin"
      redirect_to main_app.root_path # note here, you have to prefix root path with main app (very hard to find this in docs)
    end
  end
end
