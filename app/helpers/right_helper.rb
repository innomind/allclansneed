module RightHelper

  #target is the known :contr =>... :action pair
  #action is mandatory
  
  def access_link name, target, html_options = {}
    if accessable? target, html_options
      target = target.delete(:path) if target.has_key?(:path) if target.is_a? Hash
      link_to name, target, html_options
    end
  end
  
  def accessible? check, html_options
    accessable? check
  end
  
  # why is logic in the helper file?
  def accessable? target, html_options = {}
    @current_session.can_access_link? target, html_options
  end
  
  def access_link_if condition, name, target, html_options = {}
    access_link(name, target, html_options) if condition
  end
  
  def access_link_unless condition, name, target, html_options = {}
    access_link(name, target, html_options) unless condition
  end
  
  def access_remote_link name, target, html_options = {}
    link_to_remote name, target, html_options if accessable?(target, html_options)
  end

  def if_accessible target, &block
    block.call if @current_session.can_access? target
  end
  
  def urlize_controller contr_name_or_class
    contr_name_or_class.to_s.underscore.gsub(/_controller$/, '')
  end
end
