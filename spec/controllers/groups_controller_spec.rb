require File.dirname(__FILE__) + '/../spec_helper'

describe GroupsController, "A user who can create a group" do
  
  it "should  be shown a notice if the group is saved" do
    get :create, :name => "Testgruppe", :description => "TestDescription"    
    flash[:notice].should == "Gruppe erfolgreich angelegt"
  end
  
  it "should be redirected to the overview if the group is saved" do
    get :create, :name => "Testgruppe", :description => "TestDescription"    
    response.should redirect_to(:action => "index")
  end
  
  it "should be shown an error if the group is not saved" do
    get :create, :name => "", :description => ""    
    flash[:notice].should == "Gruppe konnte nicht angelegt werden"
  end
  
  it "should be shown an error if the group is not valid" do
    get :create, :name => "", :description => ""    
    flash[:notice].should == "Gruppenname nicht valid"
    response.should redirect_to(:action => "new")
  end
end