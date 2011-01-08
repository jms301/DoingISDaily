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

