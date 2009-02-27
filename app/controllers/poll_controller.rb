class PollController < ApplicationController
  add_breadcrumb 'Polls', "polls_path"
    
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC,
    :vote => PUBLIC
  }  
    
  def index
    @polls = Poll.find(:all, :order => "created_at DESC")
  end
  
  def show
    @poll = Poll.find_by_id params[:id], :include => :poll_options, :order => "vote_count"
    add_breadcrumb @poll.title
    result = PollResult.find :first, :conditions => {:poll_id => @poll, :user_id => current_user}
    if result.nil? and @poll.open?
      @result = PollResult.new
      render :template => "poll/vote"
    end
  end  
  
  def new
    add_breadcrumb 'Poll erstellen'
    @poll = Poll.new
    2.times { @poll.poll_options.build }
  end
  
  def create
    @poll = Poll.new(params[:poll])
     
    if @poll.save
      flash[:notice] = "Poll erfolgreich erstellt"
      redirect_to polls_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @poll = Poll.find_by_id params[:id]
    add_breadcrumb @poll.title
  end
  
  def update
    @poll = Poll.find_by_id params[:id]
    if @poll.update_attributes(params[:poll])
      flash[:notice] = "Poll gespeichert"
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end
  
  def vote
    @poll = Poll.find_by_id params[:id], :include => :poll_options
    
    result = @poll.poll_results.new(params[:poll_result])
    result.user = current_user

    if result.save
      flash[:notice] = "Dein Vote wurde gespeichert"
      redirect_to :action => "show", :id => params[:id]
    else
      render :action => "show", :id => params[:id]
    end
  end
  
  def open
    @poll = Poll.find_for_site_by_id params[:id]
    @poll.open = true
    @poll.save
    redirect_to polls_path
  end
  
  def close
    @poll = Poll.find_for_site_by_id params[:id]
    @poll.open = false
    @poll.save
    redirect_to polls_path
  end
  
end
