module Widgets
  module TooltipHelper
    include CssTemplate
    
    def tooltip(name=nil, opts={}, &proc)
      if name.kind_of?(Hash) # called like this: <%= tooltip :name => 'aaa', :partial => 'mytooltip' %>
        opts = name
        name = opts[:name]
      end
      
      opts[:show_mode] ||= "klick"
      
      opts[:id] ||= rand(1000)
      name ||= image_tag('widgets/tooltip_image.gif', :border => 0)
 
      result = ''
      result << tooltip_css
      
      if opts[:show_mode] == "ajax"
        result << tooltip_link_ajax(opts[:id], name, opts[:update_url])
      else
        result << tooltip_link(opts[:id],name)
      end
      
      if opts[:show_mode] == "mouseover"
        result << javascript_tag(tooltip_link_function_mouse_over(opts[:id]))
      else
        result << javascript_tag(tooltip_link_function_klick(opts[:id]))
      end
      
      result << render_tooltip(name, tooltip_content(opts,&proc), opts)
      
      if block_given?
        concat result, proc.binding; 
        return nil
      else
        return result
      end
    end
    
    def tooltip_css
      return ''
      unless @_tooltip_css_done
        @_tooltip_css_done = true
        return render_css('tooltip')
      else
        ''
      end
    end
    
    def tooltip_content(opts={}, &proc)
      return opts[:text] if opts[:text]
      return render(:partial => opts[:partial]) if opts[:partial]
      return capture(&proc) unless proc.nil?
      return image_tag("loading.gif") if opts[:show_mode] == "ajax"
    end
       
    def tooltip_link(id, name)
      link_to name, 'javascript:void(0)', :id => "tooltip_link_#{id}"
    end
    
    def tooltip_link_ajax(id, name, update_url)
      link_to_function name, "showAjaxTooltip('#{id}', '#{url_for(update_url)}')", :id => "tooltip_link_#{id}"
    end
    
    def tooltip_link_function_klick(id)
      "$('tooltip_link_#{id}').observe('click', function(event){toggleTooltip(event, $('tooltip_#{id}'))});"
    end

    def tooltip_link_function_mouse_over(id)
      "$('tooltip_link_#{id}').observe('mouseover', function(event){showTooltip(event, $('tooltip_#{id}'))});" +
      "$('tooltip_link_#{id}').observe('mouseout', function(event){hideTooltip(event, $('tooltip_#{id}'))});" 
    end

    def close_tooltip_link(id, message = 'close')
      message ||= 'close'
      link_to_function message, "$('tooltip_#{id}').hide()"
    end
    
    def render_tooltip(name, content, opts)
      render :partial => "boxes/layouts/standard", :locals => { :opts => opts,
                                                                :content => content,
                                                                :name => name }
    end
  end
end
