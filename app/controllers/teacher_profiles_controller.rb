class TeacherProfilesController < ProfilesController
  def index
    t = TeacherProfile.arel_table
    #@teacher_profiles = TeacherProfile.order_by_average_rating.where(t[:online].eq("true").or(t[:in_person].eq("true")))
    if params[:instruction_option]
      @teacher_profiles = TeacherProfile.instruction_type(params[:instruction_option])
    else
      @teacher_profiles = TeacherProfile.all
    end
    #generator = ConditionGenerator.new
    #if params[:ratings_option] || params[:instruction_option]
    #  #condition = generator.bool_generator(params[:instruction_option])
    #  #@teacher_profiles = TeacherProfile.where(condition[0], condition[1])
    #  return render text: params
    #elsif params[:price_option]
    #  @teacher_profiles = TeacherProfile.by_price(params[:price_option])
    #else
    #  @teacher_profiles = TeacherProfile.order_by_average_rating + TeacherProfile.zero_review_records
    #end
  end
end


# {"instruction_option"=>["in_person", "online"], "ratings_option"=>"order_by_average_rating", "price_option"=>"20", "action"=>"index", "controller"=>"teacher_profiles"}
