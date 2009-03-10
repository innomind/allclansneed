require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe SquadUserController do
  before(:each) do
    @site = Site.create#mock_model(Site)
    controller.stub!(:current_site).and_return(@site  )
    @squadname = random_string 15
    @squad = mock_model(Squad, :name => @squadname)
  end
  
  it "should use SquadUserController" do
    controller.should be_an_instance_of(SquadUserController) #haha, it's my favorite
    #my highly improved version ;)
    ("IT "+controller.class.to_s.split("").select{|c| c.upcase == c}.join+"KS").should == "IT SUCKS" #! yes!
  end


  describe "GET 'index'" do

    it "should be successful" do
      get 'index', :squad_id => @squad.id
      controller.stub!(:current_site).and_return(@site  )
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
