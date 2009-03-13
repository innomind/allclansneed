require 'net/https'
require 'net/http'
require 'rexml/document'
require "uri"
include REXML

class Autodns
  @@document = nil
  def initialize (task, domain)
    #Creating XML-Skeleton
    @document = Document.new
      @document.add_element("request")
    build_auth_tag
    build_task_tag task, domain 
  end
  
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
  end
  
  def build_task_tag (task, domain)
    
    case task
    when (task == :check) then
      #building domain check
      task = Element.new("task")
      task.add_element("code")
      task.elements["code"].text = "0105"

      domain = Element.new("domain")
      domain.add_element("name")
      domain.elements["name"].text = domain

      task.elements << domain
    when (task == :register) then
      #building domain check
    end
    
    @document.elements["request"].elements << task
  end
  
  def request
    @http = Net::HTTP.new('gateway.autodns3.de', 443)
    @http.use_ssl = true
    @http.start() {|http|
      resp, data = http.post('/', @document.to_s)
      return resp.body
    }
  end
end