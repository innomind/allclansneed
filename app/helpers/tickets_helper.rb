module TicketsHelper
  def supporter_area(&block)
    if @user.is_supporter?
      concat capture(&block)
    end
  end
end
