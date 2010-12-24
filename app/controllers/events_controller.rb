# Copyright (c) 2010 - James Southern
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 
# Copyright (c) 2010 - James Southern 
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# 


class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index

    @title = 'Todays Events ('+ Time.now.to_date.to_s + ')'


    @current_event, @events = Event.find_todays_events
    @plans = Plan.find(:all)
    @new_event = Event.new
    @new_plan = Plan.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  #ents/1/edit
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.xml
  def create

    @title = 'Todays Events ('+ Time.now.to_date.to_s + ')'
    @current_event, @events = Event.find_todays_events()
    @plans = Plan.find(:all)
    unless params[:events]['end_time(3i)'].blank?
      params[:event]['end_time(1i)'] = Time.now.year.to_s
      params[:event]['end_time(2i)'] = Time.now.month.to_s
    end

    @new_event = Event.new(params[:event])
    @new_plan = Plan.new()

    respond_to do |format|
      if @new_event.save
        flash[:notice] = 'Event was successfully created.'
        format.html { redirect_to(events_path()) }
        format.xml  { render :xml => @new_event, :status => :created, 
                             :location => @new_event }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @new_event.errors, 
                             :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@event) }
        format.xml  { head :ok }
      else
        format.html { render(:event => "edit") }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml  { head :ok }
    end
  end
end
