module ReviewsHelper
  def generate_stars(number_of_stars)
    star_string = get_star_string("star", number_of_stars)
    star_string += get_star_string("star-empty", (5 - number_of_stars))
  end

  def get_star_string(type, number)
    star_string = ""
    star_string += ("<i class='icon-#{type}'></i>" * number)
  end
end