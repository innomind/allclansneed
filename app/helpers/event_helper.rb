module EventHelper
  def leading_zero_on_single_digits(number)
    number > 9 ? number : "0#{number}"
  end
  
  def leading_zero(number)
    leading_zero_on_single_digits(number)
  end
end
