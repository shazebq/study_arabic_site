class TeacherProfilesController < ProfilesController
  def index
    if params[:ratings_option] == "order_by_reviews"
      @teacher_profiles = TeacherProfile.send(params[:ratings_option]).instruction_type(params[:instruction_option]).
                          by_price(params[:price_option])

    elsif params[:ratings_option] == "order_by_average_rating"
      @teacher_profiles = TeacherProfile.send(params[:ratings_option]).instruction_type(params[:instruction_option]).
                          by_price(params[:price_option]) + TeacherProfile.zero_review_records
    else
      @teacher_profiles = TeacherProfile.order_by_average_rating + TeacherProfile.zero_review_records
    end
  end
end


# {"instruction_option"=>["in_person", "online"], "ratings_option"=>"order_by_average_rating", "price_option"=>"20", "action"=>"index", "controller"=>"teacher_profiles"}
#  def chain_methods 
#    ["instruction_type", "by_price"].inject() { |initial, additional| initial.send(additional, params[additional.to_sym])
#  end

