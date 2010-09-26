class PastActionsController < ApplicationController
  # GET /past_actions
  # GET /past_actions.xml
  def index
    @past_actions = PastAction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @past_actions }
    end
  end

  # GET /past_actions/1
  # GET /past_actions/1.xml
  def show
    @past_action = PastAction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @past_action }
    end
  end

  # GET /past_actions/new
  # GET /past_actions/new.xml
  def new
    @past_action = PastAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @past_action }
    end
  end

  # GET /past_actions/1/edit
  def edit
    @past_action = PastAction.find(params[:id])
  end

  # POST /past_actions
  # POST /past_actions.xml
  def create
    @past_action = PastAction.new(params[:past_action])

    respond_to do |format|
      if @past_action.save
        flash[:notice] = 'PastAction was successfully created.'
        format.html { redirect_to(@past_action) }
        format.xml  { render :xml => @past_action, :status => :created, :location => @past_action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @past_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /past_actions/1
  # PUT /past_actions/1.xml
  def update
    @past_action = PastAction.find(params[:id])

    respond_to do |format|
      if @past_action.update_attributes(params[:past_action])
        flash[:notice] = 'PastAction was successfully updated.'
        format.html { redirect_to(@past_action) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @past_action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /past_actions/1
  # DELETE /past_actions/1.xml
  def destroy
    @past_action = PastAction.find(params[:id])
    @past_action.destroy

    respond_to do |format|
      format.html { redirect_to(past_actions_url) }
      format.xml  { head :ok }
    end
  end
end
