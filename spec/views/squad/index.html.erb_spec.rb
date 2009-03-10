require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/squad/index" do
  before(:each) do
    @squad_names = []
    10.times {@squad_names << (random_string 15)}
    @squads = model_mocks Squad, @squad_names, :name
    @clan_name = random_string 15
    @clan = mock_model(Clan, :name => @clan_name)
    @clan.stub!(:squads).and_return(@squads)
    assigns[:clan] = @clan
    render 'squad/index'
  end

  it "should show the clan name" do
    response.should have_text(/#{@clan_name}/)
  end

  it "should show all squads of a clan" do
    @squad_names.each {|sq_name| response.should have_text(/#{sq_name}/)}
  end
  
end
