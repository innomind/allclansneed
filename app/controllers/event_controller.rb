class EventController < ApplicationController
  
  CONTROLLER_ACCESS = PUBLIC

  ACTION_ACCESS_TYPES={
    :new => COMPONENT_RIGHT_OWNER,
    :create => COMPONENT_RIGHT_OWNER
  }
  
  add_breadcrumb 'Kalender', "events_path"
  
  def index
    @events = Event.find(:all)
    @year = (params[:year].nil?) ? Time.now.year : params[:year].to_i
    
    if (params[:month].nil?)
      @month = Time.now.month
    else
      @month = params[:month].to_i
      if (@month < 1)
        @month = 12
        @year += 1
      end
      if (@month > 12)
        @month = 1
        @year += 1
      end
    end
  end  
  
  def show
    @event = Event.find(:first, :conditions => {:id => params[:id]})
    add_breadcrumb @event.name
  end  
  
  def new
    @event = Event.new
    add_breadcrumb "neuen Eintrag erstellen"
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
  
  def showDay
    @day = params[:date].to_date
    @events = Event.find(:all, :conditions => ["created_at > ? and created_at < ?",@day, @day + 1.day], :order => "expire_at ASC")
    add_breadcrumb "Tag: " + Time.parse(@day)
  end

end

