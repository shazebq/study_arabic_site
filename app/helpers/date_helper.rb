module DateHelper

  def date_and_time(date_object)
    date_object.strftime("%m/%d/%Y %I:%M%p")
  end
end
