class TestingsController < ApplicationController
  # GET /testings
  # GET /testings.xml
  def index
    @testings = Testings.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @testings }
    end
  end

  # GET /testings/1
  # GET /testings/1.xml
  def show
    @testings = Testings.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @testings }
    end
  end

  # GET /testings/new
  # GET /testings/new.xml
  def new
    @testings = Testings.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @testings }
    end
  end

  # GET /testings/1/edit
  def edit
    @testings = Testings.find(params[:id])
  end

  # POST /testings
  # POST /testings.xml
  def create
    @testings = Testings.new(params[:testings])

    respond_to do |format|
      if @testings.save
        flash[:notice] = 'Testings was successfully created.'
        format.html { redirect_to(@testings) }
        format.xml  { render :xml => @testings, :status => :created, :location => @testings }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @testings.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /testings/1
  # PUT /testings/1.xml
  def update
    @testings = Testings.find(params[:id])

    respond_to do |format|
      if @testings.update_attributes(params[:testings])
        flash[:notice] = 'Testings was successfully updated.'
        format.html { redirect_to(@testings) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @testings.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /testings/1
  # DELETE /testings/1.xml
  def destroy
    @testings = Testings.find(params[:id])
    @testings.destroy

    respond_to do |format|
      format.html { redirect_to(testings_url) }
      format.xml  { head :ok }
    end
  end
end
