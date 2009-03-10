require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')


describe "/squad/edit" do
  before(:each) do
    @tpl= 'squad/edit'
    @test_name = random_string 15
    @squad = mock_model(Squad)#, :name => "testsquad")
    @squad.stub!(:name).and_return(@test_name)
    @squad.stub!(:errors).and_return(mock_model(ActiveRecord::Errors, :on => false))
    assigns[:squad] = @squad
    #template.should_receive(:render)#.with(:partial => '')
    render @tpl
  end

  it "should display the current squad-name in a form-field" do
    response.should have_tag("input[value=#{@test_name}]")
    #template.should_receive(:render)#.with(:partial => '')
  end

  it "should have a submit button" do
    response.should have_tag("input[type=submit]")
  end
end
