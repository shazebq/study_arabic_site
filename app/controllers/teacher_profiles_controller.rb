class TeacherProfilesController < ProfilesController
  def index
    generator = ConditionGenerator.new
    if params[:ratings_option] && params[:instruction_option]
      condition = generator.bool_generator(params[:instruction_option])
      @teacher_profiles = TeacherProfile.where(condition[0], condition[1])
    elsif params[:price_option]
      @teacher_profiles = TeacherProfile.by_price(params[:price_option])
    else
      @teacher_profiles = TeacherProfile.order_by_average_rating + TeacherProfile.zero_review_records
    end
  end
end
