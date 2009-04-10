module RightHelper
  
  def access_link name, target, html_options = {}
    if accessable? target, html_options
      target = target.delete(:path) if target.has_key?(:path) if target.is_a? Hash
      link_to name, target, html_options
    end
  end
  
  def accessible? check, html_options
    accessable? check
  end
  
  def accessable? target, html_options = {}
    @current_session.can_access_link? target, html_options
  end
  
  def access_link_if condition, name, target, html_options = {}
    access_link(name, target, html_options) if condition
  end
  
  def access_link_unless condition, name, target, html_options = {}
    alternate = html_options.delete(:alternate_text)
    return access_link(name, target, html_options) unless condition
    tooltip(name, :show_mode => "mouseover", :text => alternate) unless alternate.nil?
  end
  
  def access_remote_link name, html_options = {}
    link_to_remote name, html_options if accessable?(html_options[:url], html_options)
  end

  def if_accessible target, &block
    block.call if @current_session.can_access? target
  end
  
  def access_ajax_tooltip name, options
    ajax_tooltip(name,options) if accessable? options[:update_url], options
  end
  
end
