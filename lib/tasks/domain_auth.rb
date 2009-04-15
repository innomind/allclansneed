def build_auth_tag
  #Building authorization tag
  auth = Element.new("auth")
  auth.add_element("user")
  auth.add_element("password")
  auth.add_element("context")
    
  auth.elements["user"].text = "2009_04_16_innomind_th"
  auth.elements["password"].text = "wesner"
  auth.elements["context"].text = "1"
    
  #adding authorization-tag to document
  @document.elements["request"].elements << auth
  @document.elements["request"].add_element("demo")
  @document.elements["request/demo"].text = 1
end