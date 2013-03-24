class TeacherProfilesController < ProfilesController
  def index
    @countries = Country.joins(:users).where("users.profile_type = ?", "TeacherProfile").uniq # all the countries that teachers are from (unique)
    if params[:ratings_option] == "order_by_reviews"
      @teacher_profiles = TeacherProfile.only_approved.send(params[:ratings_option]).chain_scopes(params).paginate(page: params[:page], per_page: PER_PAGE)
    elsif params[:ratings_option] == "order_by_average_rating"
      @teacher_profiles = (TeacherProfile.only_approved.send(params[:ratings_option]).chain_scopes(params) + 
                          TeacherProfile.only_approved.zero_review_records.chain_scopes(params)).paginate(page: params[:page], per_page: PER_PAGE)
    else
      @teacher_profiles = (TeacherProfile.only_approved.order_by_average_rating + 
                          TeacherProfile.only_approved.zero_review_records).paginate(page: params[:page], per_page: PER_PAGE)
    end
  end

  def search
    @countries = Country.joins(:users).where("users.profile_type = ?", "TeacherProfile").uniq # all the countries that teachers are from (unique)
    @teacher_profiles = TeacherProfile.text_search(params[:query]).paginate(page: params[:page], per_page: PER_PAGE) 
    render "index"
  end
end
  

