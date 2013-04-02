module MiscTasks
  # for creating city if it doesn't already exist and assigning the selected country's id to it
  # also returns the revised list of nested params for the create action in centers_controller to use
  def handle_city_creation(params, city_child)
    city_name, country_id = get_city_and_country(params, city_child)
    if city_name.blank? || country_id.blank?
      return params  # let controller handle the validation
    end
    city = City.where(name: city_name.titleize, country_id: country_id, country_iso: (Country.find(country_id).iso)).first_or_create
    params[:address_attributes][:city_id] = city.id if city_child == :address
    params[:city_id] = city.id if city_child == :teacher_profile
    params
  end

  def get_city_and_country(params, city_child)
    if city_child == :address
      city_name = params[:address_attributes][:city_name]
      country_id = params[:address_attributes][:country_id]
    elsif city_child == :teacher_profile
      city_name = params[:city_name]
      country_id = params[:user_attributes][:country_id]
    end
    return city_name, country_id
  end
end



