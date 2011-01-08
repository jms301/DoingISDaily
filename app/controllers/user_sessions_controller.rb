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
class UserSessionsController < ApplicationController
  before_filter :current_user
  before_filter :require_user, :only => :destroy

  #def modal_login 
  #  # if it's not an ajax request something dodgey is going on so ignore it
  #  if request.xhr? 
  #    render :update do |page|
  #      page.replace_html('recaptcha', :partial=>'users/recaptcha')
  #      page.call('ISDaily.modalLogin', 'modal_login', params[:redirect_to])
  #    end
  #  else
  #    render :text=>'something went wrong'
  #  end
  #end

  def show
    # allow non-js peeps to destroy their session
  end
  
  def new
    @user_session = UserSession.new
    render :layout=>false
  end

  def reset
    usr = User.find_by_login(params[:login])
    @success = usr.reset_password unless usr.blank?
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])

    @user_session.save do |result|
      if request.xhr? 
        if result
          render :update do |page|
            page.redirect_to(params[:modal_redirect_to_login]) 
          end
        else
          render :update do |page| 
            page.alert("Wrong username/password?") 
          end
        end
      else
        if result
          flash[:notice] = "Login successful!"
          if !params[:return_to].blank? and
             params[:return_to].gsub!('needs_logon=true&', '') == nil 
            params[:return_to].gsub!('?needs_logon=true', '') 
          end
          redirect_to(params[:return_to] || :root)
        else
          render :action => :new, :layout=>false
        end
      end
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to (params[:return_to] || :root )
  end
end

