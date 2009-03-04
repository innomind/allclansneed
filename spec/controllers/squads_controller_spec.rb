# To change this template, choose Tools | Templates
# and open the template in the editor.

#require 'squads_controller'
require File.dirname(__FILE__) + '/../spec_helper'

describe SquadsController do
  before(:each) do
    #@squads_controller = SquadsController.new
  end

  it "should give an index-page" do
    controller.stub!(:current_site).and_return(Site.find_by_id(Site::PORTAL_ID))
    get :index
    response.should be_success
  end
end
