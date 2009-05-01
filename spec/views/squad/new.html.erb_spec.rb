require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/squad/new" do
  before(:each) do
    @tpl =  'squad/new'
    @clan_name = random_string 15
    @clan = mock_model(Clan, :name => @clan_name)
    assigns[:clan] = @clan
    render @tpl
  end
  
  it "should display the clan name where the new squad is created on" do
    response.should have_text(/#{@clan_name}/)
  end

  it "should contain an empty input-field for the squad name" do
    response.should have_tag("input")
  end

  it "should contain a submit-button" do
    response.should have_tag("input[type=submit]")
  end

end
