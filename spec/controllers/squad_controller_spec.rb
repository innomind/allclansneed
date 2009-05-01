require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SquadController do
  before(:each) do
     controller.stub!(:current_site).and_return(Site.find_by_id(Site::PORTAL_ID))
  end
  it "should use SquadController" do
    controller.should be_an_instance_of(SquadController)
  end

  describe "GET 'index'" do
    it "should be successful" do
      controller.stub!(:current_site).and_return(Site.find_by_id(Site::PORTAL_ID))
      get :index
      @clan.should_not be_nil
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
end
