#!/usr/bin/ruby

require 'net/https'
require 'net/http'
require 'rexml/document'
require "uri"
include REXML

class Autodns
  
  def initialize
    #Creating XML-Skeleton
    document = Document.new
      document.add_element("request")
      
    build_auth_tag document
    build_task_tag document
    request document

  end
  
  def build_auth_tag document
    #Building authorization tag
    auth = Element.new("auth")
      auth.add_element("user")
      auth.add_element("password")
      auth.add_element("context")
      
      auth.elements["user"].text = "innomind"
      auth.elements["password"].text = "pa78xcv"
      auth.elements["context"].text = "4"
      
      #adding authorization-tag to document
      document.elements["request"].elements << auth
  end
  
  def build_task_tag document
    #building some tasks
    task = Element.new("task")
    task.add_element("code")
    task.elements["code"].text = "0105"
  
    domain = Element.new("domain")
    domain.add_element("name")
    domain.elements["name"].text = "innomind.info"

    task.elements << domain
    document.elements["request"].elements << task
  end
  
  def request document
    @http = Net::HTTP.new('gateway.autodns3.de', 443)
    @http.use_ssl = true
    @http.start() {|http|
      resp, data = http.post('/', document.to_s)
      return resp.body
    }
    return @answer
  end
end