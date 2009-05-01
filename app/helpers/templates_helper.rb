module TemplatesHelper
  def header_tags_for template
    out = javascript_include_tag :defaults
    out << stylesheet_link_tag("#{template}/layout")
    out << stylesheet_link_tag("#{template}/style")
    out << include_tiny_mce_if_needed.to_s
    out << yield(:header_tags)
    out
  end
  
  def show_notice_and_error
    out = ""
    out << "<p class=\"notice\">#{flash[:notice]}</p>" if flash[:notice]
  	out << "<p class=\"error\">#{flash[:error]}</p>" if flash[:error]
  	out
  end
  
end
