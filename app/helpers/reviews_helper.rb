module ReviewsHelper
  def generate_stars(number_of_stars)
    if number_of_stars % 1 == 0
      star_string = get_star_string("star", number_of_stars)
      star_string += get_star_string("star-empty", (5 - number_of_stars))
    else
      star_string = get_star_string("star", (number_of_stars - 0.5).to_int)
      star_string += get_star_string("star-half", 1)
    end
  end

  def get_star_string(type, number)
    star_string = ""
    star_string += ("<i class='icon-#{type}'></i>" * number)
  end
end
