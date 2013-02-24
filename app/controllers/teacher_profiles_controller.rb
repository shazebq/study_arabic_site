class TeacherProfilesController < ProfilesController
  def index
    if params[:ratings_option]
      @teacher_profiles = TeacherProfile.order_by_reviews
    else
      @teacher_profiles = TeacherProfile.all
    end
  end
end
