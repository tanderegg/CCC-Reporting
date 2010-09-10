class UsersController < ApplicationController

  def index
  	
  	@users = current_user.viewable_users
 
  end
  
  def show
    @user = User.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_view?(@user)
  end
  
  def new
    @user = User.new
    raise Exceptions::SecurityTransgression unless current_user.can_create?(@user)
  end
  
  def create
    @user = User.new(params[:user])
    raise Exceptions::SecurityTransgression unless current_user.can_create?(@user)
    if @user.save
      flash[:notice] = "Successfully created user: <strong>#{@user.username}</strong>"
      redirect_to root_url	
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_edit?(@user)
  end
  
  def update
    @user = User.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_edit?(@user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile: <strong>#{@user.username}</strong>"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    message = "Successfully deleted account: <strong>#{@user.username}</strong>"
    @user.destroy
    flash[:notice] = message
    redirect_to users_url
  end
end
