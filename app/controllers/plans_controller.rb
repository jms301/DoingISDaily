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

class PlansController < ApplicationController
  
  # POST /events
  # POST /events.xml
  def create

    @title = 'Home ('+ Time.now.to_date.to_s + ')'
    @current_event, @events = Event.find_todays_events()
    @plans = Plan.find(:all)
    @new_event = Event.new()
   

    unless params[:plan]['deadline(3i)'].blank? and
           params[:plan]['deadline(2i)'].blank? 

      if params[:plan]['deadline(2i)'].blank? 
        params[:plan]['deadline(2i)'] = Time.now.month 
      end

      if params[:plan]['deadline(3i)'].blank? 
        params[:plan]['deadline(3i)'] = '1'
      end

      if params[:plan]['deadline(2i)'].to_i < Time.now.month or 
           (params[:plan]['deadline(2i)'].to_i == Time.now.month and 
            params[:plan]['deadline(3i)'].to_i < Time.now.day)
        params[:plan]['deadline(1i)'] = Time.now.year.next.to_s
      else
        params[:plan]['deadline(1i)'] = Time.now.year.to_s
      end
    end

    @new_plan = Plan.new(params[:plan])

    respond_to do |format|
      if @new_plan.save
        flash[:notice] = 'Plan was successfully created.'
        format.html { redirect_to(events_path()) }
        format.xml  { render :xml => @new_event, :status => :created,
                             :location => @new_event }
      else
        format.html { render :template=>"events/index" }
        format.xml  { render :xml => @new_event.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to(:root) }
      format.xml  { head :ok }
    end
  end
end
