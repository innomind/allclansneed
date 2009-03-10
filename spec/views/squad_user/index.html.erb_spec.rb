require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/squad_user/index" do

  before(:each) do
    @tpl = 'squad_user/index'
    @squad_name = random_string 15
    @squad = mock_model(Squad)
    @squad.stub!(:name).and_return(@squad_name)
    @squad.stub!(:errors).and_return(mock_model(ActiveRecord::Errors, :on => false))

    @nicks = []
    10.times {@nicks << (random_string 15)}
    @users = @nicks.inject([]){|m, nick| m << mock_model(User, :login => nick, :nick => nick)}
    @squad.stub!(:members).and_return(@users)
    @squad.stub!(:users).and_return(@users)
    assigns[:squad] = @squad
    render @tpl
  end
  
  it "should display the nick of all members" do
    @nicks.each { |nick| response.should have_text(/#{nick}/) }
  end

  it "should be an edit- and move-button present for all members" do
    pending
    #response.should have_tag("input[type=submit]", :count => @users.length*2)
  end


end
