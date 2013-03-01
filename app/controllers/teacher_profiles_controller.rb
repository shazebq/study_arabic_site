class TeacherProfilesController < ProfilesController
  def index
    @countries = Country.joins(:users).where("users.profile_type = ?", "TeacherProfile").uniq
    if params[:ratings_option] == "order_by_reviews"
      @teacher_profiles = TeacherProfile.send(params[:ratings_option]).chain_scopes(params)
    elsif params[:ratings_option] == "order_by_average_rating"
      @teacher_profiles = TeacherProfile.send(params[:ratings_option]).chain_scopes(params) + TeacherProfile.zero_review_records.chain_scopes(params)
    else
      @teacher_profiles = TeacherProfile.order_by_average_rating + TeacherProfile.zero_review_records
    end
  end
end


  

