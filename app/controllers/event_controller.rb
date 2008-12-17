class EventController < ApplicationController
  
  CONTROLLER_ACCESS = PUBLIC

  ACTION_ACCESS_TYPES={
    :new => COMPONENT_RIGHT_OWNER,
    :create => COMPONENT_RIGHT_OWNER
  }
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    @event.site = current_site
        
    if @event.save
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end
  
  def index
    @events = Event.find_for_site(:all)
    
    if (params[:year].nil?)
      @year = Time.now.year
    else
      @year = params[:year].to_i
    end
    if (params[:month].nil?)
      @month = Time.now.month
    else
      @month = params[:month].to_i
      if (@month < 1)
        @month = 12
        @year = @year - 1
      end
      if (@month > 12)
        @month = 1
        @year = @year + 1
      end
    end
  end
  
  def showDay
    @day = params[:date].to_date
    @events = Event.find_for_site(:all, :conditions => ["created_at > ? and created_at < ?",@day, @day + 1.day], :order => "expire_at ASC")
  end
  
  def showEvent
    @event = Event.find_for_site(:first, :conditions => {:id => params[:id]})
  end
end