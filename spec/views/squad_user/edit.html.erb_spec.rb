require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe "/squad_user/edit" do
  before(:each) do
    @tpl =  'squad_user/edit'
    @squad_name = random_string 15
    @squad = mock_model(Squad)
    @squad.stub!(:name).and_return(@squad_name)
    @squad.stub!(:errors).and_return(mock_model(ActiveRecord::Errors, :on => false))
    @login = random_string 15
    @user = mock_model(User, :login => @login, :nick => @login)
    @user.stub!(:errors).and_return(mock_model(ActiveRecord::Errors, :on => false))
    assigns[:user] = @user
    assigns[:squad] = @squad
    render @tpl
  end
  
  it "should contain the squad name, the user belongs to in this context" do
    response.should have_text(/#{@squad_name}/)
  end

  it "should contain the nick of the user in a form field" do
    response.should have_tag("input[value=#{@login}]")
  end
  
end
