require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/squad_user/new" do
  before(:each) do
    @tpl =   'squad_user/new'
    @squad_name = random_string 15
    @squad = mock_model(Squad)
    @squad.stub!(:name).and_return(@squad_name)
    @squad.stub!(:errors).and_return(mock_model(ActiveRecord::Errors, :on => false))
    assigns[:squad] = @squad
    render@tpl
  end

  it "should contain the squad name" do
    response.should have_text(/#{@squad_name}/)
  end

  it "should have a form-field for an email-address or nick" do
    response.should have_tag('form')
    response.should have_tag('input')
  end
end
