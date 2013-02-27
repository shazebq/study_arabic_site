class TeacherProfilesController < ProfilesController
  def index
    if params[:ratings_option] && params[:instruction_option]
      #@teacher_profiles = TeacherProfile.send(params[:ratings_option]).send(params[:instruction_option])
      #@teach_profiles += TeacherProfile.add_zero_review_records.send(params[:instruction_option]) if params[:ratings_option] = "order_by_average_rating"
    else
      @teacher_profiles = TeacherProfile.order_by_average_rating + TeacherProfile.zero_review_records
    end
  end
end
