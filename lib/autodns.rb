require 'net/https'
require 'net/http'
require 'rexml/document'
require "uri"
include REXML

class Autodns
  attr_accessor :document
  @@document = nil
  
  def initialize (task, domain)
    begin
      require "tasks/domain_#{task}.rb"
      require "tasks/domain_auth.rb"
    rescue MissingSourceFile
      return nil
    end
    
    @document = Document.new
    @document.add_element("request")
    @task = task
    @domain = domain
      
    build_auth_tag
    build_task_tag
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