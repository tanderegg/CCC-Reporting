class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.viewable_organizations
  end
  
  def show
    @organization = Organization.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_view?(@organization)
  end
  
  def new
    @organization = Organization.new
    raise Exceptions::SecurityTransgression unless current_user.can_create?(@organization)
  end
  
  def create
    @organization = Organization.new(params[:organization])
    raise Exceptions::SecurityTransgression unless current_user.can_create?(@organization)
    
    if @organization.save
      flash[:notice] = "Successfully created organization."
      redirect_to @organization
    else
      render :action => 'new'
    end
  end
  
  def edit
    @organization = Organization.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_edit?(@organization)
  end
  
  def update
    @organization = Organization.find(params[:id])
    raise Exceptions::SecurityTransgression unless current_user.can_edit?(@organization)
    
    if @organization.update_attributes(params[:organization])
      flash[:notice] = "Successfully updated organization."
      redirect_to @organization
    else
      render :action => 'edit'
    end
  end
end
