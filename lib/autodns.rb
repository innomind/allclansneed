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
    @task = task
    @domain = domain
      
    build_auth_tag
    build_task_tag
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
  
  def request
    @http = Net::HTTP.new('gateway.autodns3.de', 443)
    @http.use_ssl = true
    @http.start() {|http|
      resp, data = http.post('/', @document.to_s)
      @answer = Document.new resp.body
    }
    return @answer
  end
end