module ReviewsHelper
  def generate_stars(number_of_stars)
    if number_of_stars == nil
      star_num = 0
    else
      star_num = (number_of_stars * 10).to_i
    end

    html_string = "<span class='star-rating'><i class='rating-#{star_num}'></i></span>".html_safe
  end

  def average_stars(reviewable)
    generate_stars(reviewable.try(:reviews).average("rating").try(:round_point5))
  end

  def review_count(reviewable)
    pluralize(reviewable.try(:reviews_count), "review").html_safe
  end

  #def generate_stars_old(number_of_stars)
  #  if number_of_stars == nil || 0
  #    star_string = get_star_string("star-empty", 5).html_safe
  #  elsif number_of_stars % 1 == 0
  #    star_string = get_star_string("star", number_of_stars)
  #    star_string += get_star_string("star-empty", (5 - number_of_stars)).html_safe
  #  else
  #    star_string = get_star_string("star", (number_of_stars - 0.5).to_int)
  #    star_string += get_star_string("star-half", 1).html_safe
  #  end
  #end

  def get_star_string(number)
    star_string = ""
    number.times do |n|
      star_string += ("<i id='star_#{n + 1}' class='icon-star-empty'></i>")
    end
    star_string.html_safe
  end
end
