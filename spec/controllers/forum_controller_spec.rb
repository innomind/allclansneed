require File.dirname(__FILE__) + '/../spec_helper'

describe ForumController do
  it "should be receive a notification when created a forum" do
    #Forum.should_be true
  end
  
  it "should save a valid Forum only" do
    @forum = Forum.new
    @forum.save
    @forum.should_not be_valid
  end
  
  it "should only see The sites forum" do
    @forum1 = Forum.create(:title => "forum1", :site_id => 1)
    @forum2 = Forum.create(:title => "forum2", :site_id => 2)
  end
end