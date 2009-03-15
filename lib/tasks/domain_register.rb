def build_task_tag
  domain = @domain.split(".")
  
  #building domain check
  task_tag = Element.new("task")
  task_tag.add_element("code")
  task_tag.elements["code"].text = "0108"
  
  task_tag.add_element("sld")
  task_tag.elements["sld"].text = domain[0]
  
  task_tag.add_element("tld")
  task_tag.elements["tld"].text = domain[1]
  
  @document.elements["request"].elements << task_tag  
end