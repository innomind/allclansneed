def build_auth_tag
  #Building authorization tag
  auth = Element.new("auth")
  auth.add_element("user")
  auth.add_element("password")
  auth.add_element("context")
    
  auth.elements["user"].text = "innomind"
  auth.elements["password"].text = "pa78xcv"
  auth.elements["context"].text = "4"
    
  #adding authorization-tag to document
  @document.elements["request"].elements << auth
  @document.elements["request"].add_element("demo")
  @document.elements["request/demo"].text = 1
end