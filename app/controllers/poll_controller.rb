class PollController < ApplicationController
  def index
    @polls = Poll.find_for_site(:all)
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def show
    @poll = Poll.find_for_site(:first, :conditions => {:id => params[:id]})
    @polloptions = PollOption.find(:all, :conditions => {:poll_id => @poll.id})
  end
end
