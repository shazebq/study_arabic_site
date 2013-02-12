class TeacherProfilesController < ApplicationController
  def new
    @teacher_profile = TeacherProfile.new
    @teacher_profile.build_user
  end
  
  def create
    @teacher_profile = TeacherProfile.new(params[:teacher_profile])
    if @teacher_profile.save
      return render text: "woohoo, teacher profile AND user created!"
    else
      return render text: "boohoo, error!"
    end
  end
end
