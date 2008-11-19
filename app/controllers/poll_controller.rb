class PollController < ApplicationController
  def index
    @polls = Poll.find_for_site(:all)
  end
  
  def new
    @poll = Poll.new
    2.times { @poll.poll_options.build }
  end
  
  def create
    @poll = Poll.new(params[:poll])
    @poll.site = current_site
    @poll.user = current_user
     
    if @poll.save
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end
  
  def edit
    @poll = Poll.find_for_site(:first, :conditions => {:id => params[:id]})
  end
  
  def update
    @poll = Poll.find_for_site(:first, :conditions => {:id => params[:id]})
    if @poll.update_attributes(params[:poll])
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end
  
  def show
    @poll = Poll.find_for_site(:first, :conditions => {:id => params[:id]})
    @polloptions = PollOption.find(:all, :conditions => {:poll_id => @poll.id})
    @result = PollResult.new
  end
end
