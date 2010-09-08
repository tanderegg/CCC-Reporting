class UserSessionsController < ApplicationController

  skip_filter :access_control

  def new
  	if current_user
  		redirect_to :controller => :users, :action => :index
  		return
  	end
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully destroyed user session."
    redirect_to root_url
  end
end
