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
  before_filter :current_user, :require_user
  
  # POST /plans
  # POST /plans.xml
  def create
    @user = @current_user
    @title = 'Home ('+ Time.now.to_date.to_s + ')'
    @current_event, @events = Event.find_todays_events(@user)
    @plans = @user.plans


    unless params[:plan]['deadline(3i)'].blank? and
           params[:plan]['deadline(2i)'].blank? 

      if params[:plan]['deadline(2i)'].blank? 
        params[:plan]['deadline(2i)'] = Time.now.month.to_s
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
    @new_plan.user = @user

    unless params[:plan][:recurs] == 'recurs' 
      if params[:plan][:recurs] == 'daily' 
        @new_plan.recurs = Plan::RECURS[:daily] 
      elsif params[:plan][:recurs] == 'weekly' 
        @new_plan.recurs = Plan::RECURS[:weekly] 
      elsif params[:plan][:recurs] == 'monthly' 
        @new_plan.recurs = Plan::RECURS[:monthly] 
      end
    else 
      @new_plan.recurs = Plan::RECURS[:none] 
    end 

    unless params[:plan].blank? or params[:plan][:parent].blank?
      @new_plan.parent = @current_user.plans.find(params[:plan][:parent])
    end

    respond_to do |format|
      if @new_plan.save
        flash[:notice] = 'Plan was successfully created.'
        format.html { redirect_to(events_path()) }
        format.xml  { render :xml => @new_plan, :status => :created,
                             :location => @new_plan }
      else
        format.html { render :template=>"events/index" }
        format.xml  { render :xml => @new_plan.errors,
                             :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
    @plan = @current_user.plans.find(params[:id])
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to(:root) }
      format.xml  { head :ok }
    end
  end

  def edit
    @user = @current_user
    @plan = @user.plans.find(params[:id]) 
  end

  def update

    @plan = @current_user.plans.find(params[:id])
    unless params[:plan].blank? or params[:plan][:parent].blank?
      @plan.parent = @current_user.plans.find(params[:plan][:parent])
    end

    unless params[:plan][:recurs] == 'recurs' 
      if params[:plan][:recurs] == 'daily' 
        @plan.recurs = Plan::RECURS[:daily] 
      elsif params[:plan][:recurs] == 'weekly' 
        @plan.recurs = Plan::RECURS[:weekly] 
      elsif params[:plan][:recurs] == 'monthly' 
        @plan.recurs = Plan::RECURS[:monthly] 
      end
    else 
      @plan.recurs = Plan::RECURS[:none] 
    end 

    params.delete('parent')
    respond_to do |format|
      if @plan.update_attributes(params[:plan])
        flash[:notice] = 'Plan was successfully updated.'
        format.html { redirect_to(:root) }
        format.xml  { head :ok }
      else
        flash[:notice] = 'Plan was not cunning.'
        format.html { render(:plan => "edit") }
        format.xml  { render :xml => @plan.errors, :status => :unprocessable_entity }
      end
    end
  end


end
