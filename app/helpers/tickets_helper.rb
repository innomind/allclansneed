module TicketsHelper
  def supporter_area(&block)
    if @user.is_supporter?
      concat content_tag(:div, capture(&block))
    end
  end
end
