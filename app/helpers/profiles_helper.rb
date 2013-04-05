module ProfilesHelper
  def get_other_user_type(controller_name)
    user_type = controller_name.split("_")[0].singularize
    if user_type == "teacher"
      other_user_type = "student"
    else
      other_user_type = "teacher"
    end
  end

  def get_user_type(controller_name)
    controller_name.split("_")[0].singularize
  end

  def get_teacher_location(teacher)
    "#{teacher.try(:city).try(:name)}, #{teacher.user.try(:country).try(:name)}"
  end
end
