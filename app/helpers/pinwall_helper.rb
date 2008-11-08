module PinwallHelper
  def get_entrys ident
    Pinwall.find(:all, :conditions => "user_id = #{ident}")
  end
end
