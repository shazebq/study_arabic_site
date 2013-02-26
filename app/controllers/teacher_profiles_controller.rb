class TeacherProfilesController < ProfilesController
  def index
    if params[:ratings_option]
      @teacher_profiles = TeacherProfile.send(params[:ratings_option])
    else
      @teacher_profiles = TeacherProfile.order_by_average_rating
    end
  end
end
